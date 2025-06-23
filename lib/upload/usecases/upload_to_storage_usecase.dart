import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;
import 'package:roggle/roggle.dart';

import 'upload_to_storage_exception.dart';

/// [UploadToStorageUseCase] の Provider。
final uploadToStorageUseCaseProvider = Provider(
  (ref) => UploadToStorageUseCase(),
);

/// Firebase Storage へファイルをアップロードする UseCase。
class UploadToStorageUseCase {
  /// ロガーインスタンス。
  final Roggle logger;

  /// コンストラクタ。
  UploadToStorageUseCase({Roggle? logger}) : logger = logger ?? Roggle();

  /// ファイルを Firebase Storage にアップロードし、ダウンロード URL を返す。
  ///
  /// アップロードに失敗した場合は [UploadToStorageException] を投げる。
  Future<String> call(
    html.Blob file, {
    String? originalFileName,
    void Function(double progress)? onProgress,
  }) async {
    try {
      final ext = (originalFileName?.split('.').last.toLowerCase() ?? 'mp3')
          .replaceAll(RegExp(r'[^a-z0-9]'), '');

      final safeName = (originalFileName ?? 'audio')
          .replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_')
          .replaceAll('0', '');

      final fileName =
          'uploads/${safeName}_${DateTime.now().millisecondsSinceEpoch}.$ext';

      final storageRef = FirebaseStorage.instance.ref(fileName);
      final task = storageRef.putBlob(file);

      task.snapshotEvents.listen((snapshot) {
        if (onProgress != null) {
          final progress = snapshot.bytesTransferred / snapshot.totalBytes;
          onProgress(progress);
        }
      });
      final result = await task;
      return await result.ref.getDownloadURL();
    } catch (e) {
      logger.e('アップロードに失敗: $e');
      throw UploadToStorageException('ファイルのアップロードに失敗しました。');
    }
  }
}
