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

      // ここでslicedをアップロード対象にする
      // 例: await uploadFile(sliced);

      state = UploadState(isUploading: true);
      // ...アップロード処理
      state = UploadState(isUploading: false);
      return;
    }

    // 15分以内ならそのままアップロード
    state = UploadState(isUploading: true);
    // ...アップロード処理
    state = UploadState(isUploading: false);
  }
}
