/// Firebase Storage アップロード時の例外。
///
/// Firebase Storage へのファイルアップロードに失敗した場合にスローされる。
class UploadToStorageException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [UploadToStorageException] のインスタンスを生成する。
  ///
  /// [message] エラーメッセージ。
  UploadToStorageException(this.message);
  @override
  String toString() => message;
}
