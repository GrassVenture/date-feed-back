import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/http_client.dart';

/// [AudioAnalysisUseCase] のインスタンスを提供する Provider。
final audioAnalysisUseCaseProvider = Provider<AudioAnalysisUseCase>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AudioAnalysisUseCase(httpClient);
});

/// 音声ファイルの分析を実行するユースケースクラス。
///
/// Firebase Storage へのアップロード後、音声分析 API を呼び出して分析結果を取得する。
class AudioAnalysisUseCase {
  final HttpClient _httpClient;

  /// [AudioAnalysisUseCase] を生成する。
  ///
  /// [httpClient] には [HttpClient] のインスタンスを注入する。
  AudioAnalysisUseCase(this._httpClient);

  /// 音声ファイルの分析を実行する。
  ///
  /// [audioUrl] には Firebase Storage 上の音声ファイルの URL を指定する。
  /// 成功時は API レスポンスの JSON マップを返す。
  /// 失敗時は例外をスローする。
  Future<Map<String, dynamic>> analyzeConversation({
    required String audioUrl,
    String? userId,
    String? accessToken,
  }) async {
    // Cloud Run API へのリクエストを実行
    return await _httpClient.requestAudioAnalysis(
      fileUri: audioUrl,
      userId: userId,
      accessToken: accessToken,
    );
  }
}
