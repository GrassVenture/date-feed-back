/// 音声ファイル検証の例外。
class ValidateAudioFileException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [ValidateAudioFileException] のインスタンスを生成する。
  ValidateAudioFileException(this.message);
  @override
  String toString() => message;
}
