import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import '../models/upload_state.dart';
import '../usecases/validate_audio_file_usecase.dart';
import '../usecases/extract_audio_segment_usecase.dart';
import '../usecases/upload_to_storage_usecase.dart';
import '../usecases/request_analysis_usecase.dart';
import '../usecases/validate_audio_file_exception.dart';
import '../usecases/extract_audio_segment_exception.dart';
import '../usecases/upload_to_storage_exception.dart';
import '../usecases/request_analysis_exception.dart';

/// アップロード状態を管理する [NotifierProvider]。
final uploadControllerProvider =
    NotifierProvider<UploadController, UploadState>(UploadController.new);

/// 音声ファイルのアップロード処理を管理する Notifier。
class UploadController extends Notifier<UploadState> {
  @override
  /// アップロード状態の初期化を行う。
  UploadState build() {
    return const UploadState();
  }

  /// ドロップまたは選択されたファイルを処理し、アップロードする。
  Future<void> handleDroppedFile(html.File file) async {
    final validateAudioFile = ref.read(validateAudioFileUseCaseProvider);
    final extractAudioSegment = ref.read(extractAudioSegmentUseCaseProvider);
    final uploadToStorage = ref.read(uploadToStorageUseCaseProvider);
    final requestAnalysis = ref.read(requestAnalysisUseCaseProvider);

    // 検証＋音声長取得
    double duration;
    try {
      duration = await validateAudioFile.call(file);
    } on ValidateAudioFileException catch (e) {
      state = UploadState(error: e.message);
      return;
    } catch (e) {
      state = UploadState(error: 'ファイル検証中に予期せぬエラーが発生しました: $e');
      return;
    }

    // 15分抽出
    html.Blob uploadBlob;
    try {
      uploadBlob = await extractAudioSegment.call(file, duration);
    } on ExtractAudioSegmentException catch (e) {
      state = UploadState(error: e.message);
      return;
    } catch (e) {
      state = UploadState(error: '音声セグメント抽出中に予期せぬエラーが発生しました: $e');
      return;
    }

    // アップロード
    state = const UploadState(isUploading: true);
    String? downloadUrl;
    try {
      downloadUrl = await uploadToStorage.call(
        uploadBlob,
        originalFileName: file.name,
        onProgress: (progress) {
          state = UploadState(isUploading: true, progress: progress);
        },
      );
    } on UploadToStorageException catch (e) {
      state = UploadState(isUploading: false, error: e.message);
      return;
    } catch (e) {
      state = UploadState(
        isUploading: false,
        error: 'アップロード中に予期せぬエラーが発生しました: $e',
      );
      return;
    }

    // 分析API呼び出し
    try {
      unawaited(
        requestAnalysis.call(
          fileUri: downloadUrl,
          userId: '3M7z7EVShLNEAR8pQRZkgZFJti13', // 固定値
        ),
      );
    } on RequestAnalysisException catch (e) {
      state = UploadState(
        isUploading: false,
        error: e.message,
        downloadUrl: downloadUrl,
      );
      return;
    } catch (e) {
      state = UploadState(
        isUploading: false,
        error: '音声分析中に予期せぬエラーが発生しました: $e',
        downloadUrl: downloadUrl,
      );
      return;
    }

    state = UploadState(
      isUploading: false,
      progress: 1.0,
      downloadUrl: downloadUrl,
    );
  }

  /// アップロード状態を初期化する。
  void reset() {
    state = const UploadState();
  }
}
