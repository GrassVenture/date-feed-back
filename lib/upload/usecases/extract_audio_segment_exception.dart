/// 音声セグメント抽出時の例外。
///
/// 音声ファイルからセグメント抽出に失敗した場合にスローされる。
class ExtractAudioSegmentException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [ExtractAudioSegmentException] のインスタンスを生成する。
  ///
  /// [message] エラーメッセージ。
  ExtractAudioSegmentException(this.message);
  @override
  String toString() => message;
}
