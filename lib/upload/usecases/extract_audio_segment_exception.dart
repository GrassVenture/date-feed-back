/// 音声セグメント抽出の例外。
class ExtractAudioSegmentException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [ExtractAudioSegmentException] のインスタンスを生成する。
  ExtractAudioSegmentException(this.message);
  @override
  String toString() => message;
}
