/// 音声分析 API 呼び出し時の例外。
///
/// 音声分析 API の呼び出しに失敗した場合にスローされる。
class RequestAnalysisException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [RequestAnalysisException] のインスタンスを生成する。
  ///
  /// [message] エラーメッセージ。
  RequestAnalysisException(this.message);
  @override
  String toString() => message;
}
