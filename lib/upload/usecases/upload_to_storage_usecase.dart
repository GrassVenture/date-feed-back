import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;

/// Firebase Storage へファイルをアップロードする UseCase。
class UploadToStorageUseCase {
  /// ファイルを Firebase Storage にアップロードし、ダウンロード URL を返す。
  ///
  /// アップロードに失敗した場合は [UploadToStorageException] を投げる。
  Future<String> call(
    html.Blob file, {
    String? originalFileName,
    void Function(double progress)? onProgress,
  }) async {
    try {
      final ext = originalFileName?.split('.').last.toLowerCase() ?? 'mp3';
      final fileName =
          'uploads/audio_${DateTime.now().millisecondsSinceEpoch}.$ext';
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
      throw UploadToStorageException('アップロードに失敗しました: $e');
    }
  }
}

/// Firebase Storage アップロードの例外。
class UploadToStorageException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [UploadToStorageException] のインスタンスを生成する。
  UploadToStorageException(this.message);
  @override
  String toString() => message;
}

/// [UploadToStorageUseCase] の Provider。
final uploadToStorageUseCaseProvider = Provider(
  (ref) => UploadToStorageUseCase(),
);
