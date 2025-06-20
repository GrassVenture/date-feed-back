import 'package:dio/dio.dart';
import 'package:roggle/roggle.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// [HttpClient] のインスタンスを提供する Provider。
final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient();
});

/// HTTP 通信を担当するクライアントクラス。
///
/// 音声分析 API へのリクエストや、署名付き URL へのファイルアップロードを行う。
class HttpClient {
  /// 開発用ダミーアクセストークン。
  static const String _dummyAccessToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZGV2X3Rlc3RfdXNlcl8xMjMiLCJleHAiOjQ3OTgwMDAwMDB9.dummy_signature_abcdefg123456';

  /// 開発用ダミーユーザーID。
  static const String _dummyUserId = '3M7z7EVShLNEAR8pQRZkgZFJti13';

  /// [Dio] インスタンス。
  final Dio dio;

  /// [Roggle] ロガーインスタンス。
  final Roggle logger;

  /// [HttpClient] を生成する。
  ///
  /// [dio] と [logger] を外部から注入できる。
  HttpClient({Dio? dio, Roggle? logger})
    : dio = dio ?? Dio(),
      logger = logger ?? Roggle();

  /// Cloud Run API に音声分析をリクエストする（認証情報付き）。
  ///
  /// [fileUri] は Google Cloud Storage 上のファイル URI。
  /// [userId] はリクエストユーザーの ID。省略時は開発用ダミー値を利用する。
  /// [accessToken] は認証用アクセストークン。省略時は開発用ダミー値を利用する。
  ///
  /// 成功時は API レスポンスの JSON マップを返す。
  /// 失敗時は例外をスローする。
  Future<Map<String, dynamic>> requestAudioAnalysis({
    required String fileUri,
    String? userId,
    String? accessToken,
  }) async {
    final requestUserId = userId ?? _dummyUserId;
    final requestToken = accessToken ?? _dummyAccessToken;

    try {
      final response = await dio.post(
        '/analyzeAudio',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $requestToken',
          },
        ),
        data: {'file_uri': fileUri, 'user_id': requestUserId},
      );

      if (response.statusCode == 200) {
        logger.d('Audio analysis request successful: ${response.data}');
        return Map<String, dynamic>.from(response.data);
      } else {
        logger.e('Audio analysis request failed: ${response.data}');
        throw Exception('Analysis request failed: ${response.statusCode}');
      }
    } on DioException catch (error) {
      logger.e('DioException in audio analysis: ${error.message}');
      rethrow;
    } on Exception catch (error) {
      logger.e('Exception in audio analysis: ${error.toString()}');
      rethrow;
    }
  }
}
