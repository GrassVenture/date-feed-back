/// Firebase Storage アップロードの例外。
class UploadToStorageException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [UploadToStorageException] のインスタンスを生成する。
  UploadToStorageException(this.message);
  @override
  String toString() => message;
}
