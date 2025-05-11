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
    // 拡張子チェック
    final fileName = file.name.toLowerCase();
    if (!(fileName.endsWith('.mp3') || fileName.endsWith('.wav'))) {
      state = UploadState(error: 'MP3またはWAVファイルのみ対応しています');
      return;
    }
    // TODO: 15分超のファイルは冒頭15分だけ抽出
    // TODO: アップロード処理
    state = UploadState(isUploading: true);
    // ...アップロード処理
    state = UploadState(isUploading: false);
  }
}
