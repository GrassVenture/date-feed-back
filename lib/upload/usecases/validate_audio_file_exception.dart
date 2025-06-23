/// 音声ファイル検証時の例外。
///
/// 音声ファイルの検証に失敗した場合にスローされる。
class ValidateAudioFileException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [ValidateAudioFileException] のインスタンスを生成する。
  ///
  /// [message] エラーメッセージ。
  ValidateAudioFileException(this.message);
  @override
  String toString() => message;
}
