import 'package:dio/dio.dart';
import 'package:roggle/roggle.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../env/env.dart';

/// [HttpClient] のインスタンスを提供する Provider。
final httpClientProvider = Provider.autoDispose<HttpClient>((ref) {
  return HttpClient();
});

/// HTTP 通信を担当する汎用クライアントクラス。
///
/// API へのリクエストやファイルアップロードなど、共通的な HTTP 通信処理を提供する。
class HttpClient {
  /// [Dio] インスタンス。
  final Dio dio;

  /// [Roggle] ロガーインスタンス。
  final Roggle logger;

  /// [HttpClient] を生成する。
  ///
  /// [dio] と [logger] を外部から注入できる。
  HttpClient({Dio? dio, Roggle? logger})
    : dio = dio ?? Dio(BaseOptions(baseUrl: Env.devApiUrl)),
      logger = logger ?? Roggle();

  /// POST リクエストを送信する。
  ///
  /// [endpoint] はリクエスト先のエンドポイント。
  /// [data] はリクエストボディ。
  /// [headers] で追加ヘッダーを指定できる。
  ///
  /// 成功時は API レスポンスの JSON マップを返す。
  /// 失敗時は例外をスローする。
  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        options: Options(
          headers: {'Content-Type': 'application/json', ...?headers},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        logger.d('POST $endpoint successful: \\${response.data}');
        return Map<String, dynamic>.from(response.data);
      } else {
        logger.e('POST $endpoint failed: \\${response.data}');
        throw Exception('POST request failed: \\${response.statusCode}');
      }
    } on DioException catch (error) {
      logger.e('DioException in POST $endpoint: \\${error.message}');
      rethrow;
    } on Exception catch (error) {
      logger.e('Exception in POST $endpoint: \\${error.toString()}');
      rethrow;
    }
  }
}
