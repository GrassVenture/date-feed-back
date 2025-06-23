import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import '../../analysis/services/analysis_service.dart';
import '../models/upload_state.dart';

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
    final fileName = file.name.toLowerCase();
    if (!(fileName.endsWith('.mp3') || fileName.endsWith('.wav'))) {
      state = const UploadState(error: 'MP3またはWAVファイルのみ対応しています');
      return;
    }

    // 音声長取得
    final audio = html.AudioElement();
    audio.src = html.Url.createObjectUrl(file);

    try {
      await audio.onLoadedMetadata.first;
    } catch (e) {
      state = const UploadState(error: '音声ファイルのメタデータ取得に失敗しました');
      return;
    }

    const maxDurationSec = 15 * 60; // 15分=900秒
    if (audio.duration > maxDurationSec) {
      // ファイルサイズとdurationから冒頭15分分のバイト数を計算
      final maxBytes = (file.size * (maxDurationSec / audio.duration)).floor();
      final sliced = file.slice(0, maxBytes, file.type);

      state = const UploadState(isUploading: true);
      await uploadFile(sliced, originalFileName: file.name);
      state = const UploadState(isUploading: false);
      return;
    }

    // 15分以内ならそのままアップロード
    state = const UploadState(isUploading: true);
    await uploadFile(file);
    state = const UploadState(isUploading: false);
  }

  /// ファイルを Firebase Storage にアップロードし、分析リクエストを送信する。
  ///
  /// [originalFileName] を指定した場合は拡張子に利用する。
  /// アップロード完了後、Firebase Storage のダウンロード URL を音声分析 API に渡す。
  Future<void> uploadFile(html.Blob file, {String? originalFileName}) async {
    try {
      final ext = originalFileName?.split('.').last.toLowerCase() ?? 'mp3';
      final fileName =
          'uploads/audio_${DateTime.now().millisecondsSinceEpoch}.$ext';

      final storageRef = FirebaseStorage.instance.ref(fileName);
      final task = storageRef.putBlob(file);

      task.snapshotEvents.listen((snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        state = UploadState(isUploading: true, progress: progress);
      });

      final result = await task;
      final downloadUrl = await result.ref.getDownloadURL();
      debugPrint('アップロード成功: $downloadUrl');

      // アップロード完了後、Firebase StorageのダウンロードURLを使用して音声分析APIを呼び出し
      final audioAnalysisService = ref.read(analysisServiceProvider);
      try {
        unawaited(
          audioAnalysisService.analyzeDateSession(
            fileUri: downloadUrl,
            userId: '3M7z7EVShLNEAR8pQRZkgZFJti13', // 固定値
          ),
        );
      } catch (e) {
        state = UploadState(isUploading: false, error: '音声分析に失敗しました: $e');
        return;
      }

      state = UploadState(
        isUploading: false,
        progress: 1.0,
        downloadUrl: downloadUrl,
      );
    } catch (e) {
      state = UploadState(isUploading: false, error: 'アップロードまたは分析に失敗しました: $e');
    }
  }

  /// 指定ファイル名の署名付きURLを取得する。
  ///
  /// バックエンドAPI経由で署名付きURLを取得する例。
  Future<String> fetchSignedUrl(String fileName) async {
    final response = await html.HttpRequest.request(
      '/api/gcs-signed-url?filename=$fileName', // ←ここはバックエンドのAPI仕様に合わせて修正
      method: 'GET',
    );
    if (response.status == 200) {
      return response.responseText!;
    } else {
      throw Exception('署名付きURLの取得に失敗しました');
    }
  }

  /// アップロード状態を初期化する。
  void reset() {
    state = const UploadState();
  }
}
