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
///
/// ファイルの検証、音声セグメントの抽出、クラウドストレージへのアップロード、
/// 分析 API の呼び出しといった一連のフローを制御する。
class UploadController extends Notifier<UploadState> {
  /// [UploadState] の初期状態を構築する。
  @override
  UploadState build() => const UploadState();

  /// 音声ファイルを検証する UseCase を取得する。
  ValidateAudioFileUseCase get _validateAudioFile =>
      ref.read(validateAudioFileUseCaseProvider);

  /// 音声セグメントを抽出する UseCase を取得する。
  ExtractAudioSegmentUseCase get _extractAudioSegment =>
      ref.read(extractAudioSegmentUseCaseProvider);

  /// ファイルをストレージにアップロードする UseCase を取得する。
  UploadToStorageUseCase get _uploadToStorage =>
      ref.read(uploadToStorageUseCaseProvider);

  /// 音声分析をリクエストする UseCase を取得する。
  RequestAnalysisUseCase get _requestAnalysis =>
      ref.read(requestAnalysisUseCaseProvider);

  /// ドロップされた音声ファイルを処理し、アップロードと分析要求を行う。
  ///
  /// このメソッドは、ファイル処理の各ステップ（検証、抽出、アップロード、分析要求）を実行する。
  /// 各ステップでエラーが発生した場合は、[UploadState] にエラーメッセージを設定して処理を中断する。
  ///
  /// [file] には、ユーザーによってドロップされた音声ファイルを指定する。
  Future<void> handleDroppedFile(html.File file) async {
    double duration;
    try {
      duration = await _validateAudioFile.call(file);
    } on ValidateAudioFileException catch (e) {
      state = UploadState(error: e.message);
      return;
    } catch (e) {
      state = UploadState(error: 'ファイル検証中に予期せぬエラーが発生しました: $e');
      return;
    }

    html.Blob uploadBlob;
    try {
      uploadBlob = await _extractAudioSegment.call(file, duration);
    } on ExtractAudioSegmentException catch (e) {
      state = UploadState(error: e.message);
      return;
    } catch (e) {
      state = UploadState(error: '音声セグメント抽出中に予期せぬエラーが発生しました: $e');
      return;
    }

    state = const UploadState(isUploading: true);
    String? downloadUrl;
    try {
      downloadUrl = await _uploadToStorage.call(
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

    try {
      unawaited(
        _requestAnalysis.call(
          fileUri: downloadUrl,
          userId: '3M7z7EVShLNEAR8pQRZkgZFJti13',
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
  ///
  /// 進行状況、エラーメッセージ、ダウンロード URL などをリセットし、
  /// [UploadState] を初期状態に戻す。
  void reset() {
    state = const UploadState();
  }
}
