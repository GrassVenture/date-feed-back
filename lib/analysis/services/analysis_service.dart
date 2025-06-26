import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roggle/roggle.dart';

import '../../core/services/http_client.dart';

/// [AnalysisService] のインスタンスを提供する Provider。
final analysisServiceProvider = Provider<AnalysisService>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AnalysisService(httpClient: httpClient);
});

/// 音声分析 API へのリクエストを担当するサービスクラス。
class AnalysisService {
  /// [HttpClient] インスタンス。
  final HttpClient httpClient;

  /// [Roggle] ロガーインスタンス。
  final Roggle logger;

  /// [AnalysisService] を生成する。
  ///
  /// [httpClient] を外部から注入する。
  AnalysisService({required this.httpClient}) : logger = httpClient.logger;

  /// デートセッション分析 API を呼び出す。
  ///
  /// [fileUri] は Firebase Storage 上のファイル URI。
  /// [userId] はリクエストユーザーの ID。省略時は開発用ダミー値を利用する。
  /// [accessToken] は認証用アクセストークン。省略時は開発用ダミー値を利用する。
  ///
  /// 成功時は API レスポンスの JSON マップを返す。
  /// 失敗時は例外をスローする。
  Future<Map<String, dynamic>> analyzeDateSession({
    required String fileUri,
    String? userId,
    String? accessToken,
  }) async {
    const String dummyAccessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZGV2X3Rlc3RfdXNlcl8xMjMiLCJleHAiOjQ3OTgwMDAwMDB9.dummy_signature_abcdefg123456';
    const String dummyUserId = '3M7z7EVShLNEAR8pQRZkgZFJti13';

    final requestUserId = userId ?? dummyUserId;
    final requestToken = accessToken ?? dummyAccessToken;

    return await httpClient.post(
      endpoint: '/analyzeDateSession',
      data: {'storageUrl': fileUri, 'userId': requestUserId},
      headers: {'Authorization': 'Bearer $requestToken'},
    );
  }
}
