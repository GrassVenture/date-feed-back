import 'dart:html' as html;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final uploadControllerProvider =
    NotifierProvider<UploadController, UploadState>(
  UploadController.new,
);

class UploadState {
  final bool isUploading;
  final String? error;
  final double progress;

  const UploadState({
    this.isUploading = false,
    this.error,
    this.progress = 0.0,
  });

  UploadState copyWith({
    bool? isUploading,
    String? error,
    double? progress,
  }) =>
      UploadState(
        isUploading: isUploading ?? this.isUploading,
        error: error ?? this.error,
        progress: progress ?? this.progress,
      );
}

class UploadController extends Notifier<UploadState> {
  @override
  UploadState build() => const UploadState();

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
      await uploadFile(sliced);
      state = const UploadState(isUploading: false);
      return;
    }

    // 15分以内ならそのままアップロード
    state = const UploadState(isUploading: true);
    await uploadFile(file);
    state = const UploadState(isUploading: false);
  }

  Future<void> uploadFile(html.Blob file) async {
    try {
      // 1. 署名付きURLをバックエンドから取得
      final fileName =
          'audio_${DateTime.now().millisecondsSinceEpoch}.wav'; // 拡張子は動的に
      final signedUrl = await fetchSignedUrl(fileName);

      // 2. 署名付きURLにPUTでアップロード
      final request = html.HttpRequest();
      request.open('PUT', signedUrl);

      request.upload.onProgress.listen((event) {
        if (event.lengthComputable) {
          final progress = event.loaded! / event.total!;
          state = UploadState(
            isUploading: true,
            progress: progress,
          );
        }
      });

      request.onLoadEnd.listen((event) {
        if (request.status == 200) {
          state =
              const UploadState(isUploading: false, progress: 1.0, error: null);
        } else {
          state = const UploadState(
              isUploading: false, progress: 0.0, error: 'アップロードに失敗しました');
        }
      });

      request.onError.listen((event) {
        state = const UploadState(
            isUploading: false, progress: 0.0, error: 'アップロード中にエラーが発生しました');
      });

      request.setRequestHeader('Content-Type', file.type);
      request.send(file);
      state = const UploadState(isUploading: true, progress: 0.0);
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
