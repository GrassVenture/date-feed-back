/// 音声分析 API 呼び出しの例外。
class RequestAnalysisException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [RequestAnalysisException] のインスタンスを生成する。
  RequestAnalysisException(this.message);
  @override
  String toString() => message;
}
