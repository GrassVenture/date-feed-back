import 'dart:html' as html;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final uploadControllerProvider =
    NotifierProvider<UploadController, UploadState>(
  UploadController.new,
);

class UploadState {
  final bool isUploading;
  final String? error;
  // ...他の状態
  UploadState({this.isUploading = false, this.error});
}

class UploadController extends Notifier<UploadState> {
  @override
  UploadState build() => UploadState();

  Future<void> handleDroppedFile(html.File file) async {
    final fileName = file.name.toLowerCase();
    if (!(fileName.endsWith('.mp3') || fileName.endsWith('.wav'))) {
      state = UploadState(error: 'MP3またはWAVファイルのみ対応しています');
      return;
    }

    // 音声長取得
    final audio = html.AudioElement();
    audio.src = html.Url.createObjectUrl(file);

    try {
      await audio.onLoadedMetadata.first;
    } catch (e) {
      state = UploadState(error: '音声ファイルのメタデータ取得に失敗しました');
      return;
    }

    const maxDurationSec = 15 * 60; // 15分=900秒
    if (audio.duration > maxDurationSec) {
      // ファイルサイズとdurationから冒頭15分分のバイト数を計算
      final maxBytes = (file.size * (maxDurationSec / audio.duration)).floor();
      final sliced = file.slice(0, maxBytes, file.type);

      state = UploadState(isUploading: true);
      uploadFile(sliced);
      state = UploadState(isUploading: false);
      return;
    }

    // 15分以内ならそのままアップロード
    state = UploadState(isUploading: true);
    uploadFile(file);
    state = UploadState(isUploading: false);
  }

  Future<void> uploadFile(html.Blob file) async {
    try {
      // 1. 署名付きURLをバックエンドから取得
      final fileName =
          'audio_${DateTime.now().millisecondsSinceEpoch}.wav'; // 拡張子は動的に
      final signedUrl = await fetchSignedUrl(fileName);

      // 2. 署名付きURLにPUTでアップロード
      final request = await html.HttpRequest.request(
        signedUrl,
        method: 'PUT',
        sendData: file,
        requestHeaders: {
          'Content-Type': file.type,
        },
      );

      if (request.status == 200) {
        // アップロード成功
        state = UploadState(isUploading: false, error: null);
      } else {
        // アップロード失敗
        state = UploadState(isUploading: false, error: 'アップロードに失敗しました');
      }
    } catch (e) {
      state = UploadState(isUploading: false, error: 'アップロード中にエラーが発生しました: $e');
    }
  }

// 署名付きURLを取得する関数（例: REST API経由）
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
}
