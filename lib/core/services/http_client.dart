import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roggle/roggle.dart';

/// HTTP 通信を管理するクライアントクラス。
///
/// [Dio] を利用し、認証トークンの自動付与、型安全なレスポンス、
/// インターセプターによるリクエスト・レスポンス・エラー処理、
/// タイムアウト設定、roggle によるログ出力を行う。
class HttpClient {
  /// Dio インスタンス。
  final Dio _dio;

  /// 認証トークンを取得するコールバック。
  final Future<String?> Function()? getToken;

  /// [HttpClient] を生成する。
  ///
  /// [getToken] には認証トークンを取得する非同期関数を渡す。
  HttpClient({this.getToken}) : _dio = Dio() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 認証トークン自動付与
          if (getToken != null) {
            final token = await getToken!();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          Roggle().d('リクエスト: [32m[1m${options.method} ${options.uri}[0m');
          Roggle().d('ヘッダー: ${options.headers}');
          Roggle().d('データ: ${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          Roggle().i(
            'レスポンス: ${response.statusCode} ${response.requestOptions.uri}',
          );
          Roggle().d('レスポンスデータ: ${response.data}');
          handler.next(response);
        },
        onError: (DioException e, handler) {
          Roggle().e('エラー: ${e.message} (${e.type})');
          if (e.response != null) {
            Roggle().e('エラーレスポンス: ${e.response?.data}');
          }
          handler.next(e);
        },
      ),
    );
  }

  /// GET リクエストを送信する。
  ///
  /// [T] はレスポンスの型。
  /// [path] はリクエスト先のパス。
  /// [queryParameters] でクエリを指定できる。
  /// [fromJson] で型変換を行う。
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) fromJson,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// POST リクエストを送信する。
  ///
  /// [T] はレスポンスの型。
  /// [path] はリクエスト先のパス。
  /// [data] で送信データを指定できる。
  /// [fromJson] で型変換を行う。
  Future<T> post<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) fromJson,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(path, data: data, options: options);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT リクエストを送信する。
  ///
  /// [T] はレスポンスの型。
  /// [path] はリクエスト先のパス。
  /// [data] で送信データを指定できる。
  /// [fromJson] で型変換を行う。
  Future<T> put<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) fromJson,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(path, data: data, options: options);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE リクエストを送信する。
  ///
  /// [T] はレスポンスの型。
  /// [path] はリクエスト先のパス。
  /// [data] で送信データを指定できる。
  /// [fromJson] で型変換を行う。
  Future<T> delete<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) fromJson,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(path, data: data, options: options);
      return fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Dio のエラーをアプリ用の例外に変換する。
  Exception _handleError(DioException e) {
    // 必要に応じて独自の例外クラスに変換可能
    return Exception('HTTP エラー: ${e.message}');
  }
}

/// [HttpClient] の Provider。
///
/// 認証トークン取得関数を必要に応じて差し替え可能。
final httpClientProvider = Provider<HttpClient>((ref) {
  // ここで認証トークン取得関数を注入できる
  return HttpClient(
    getToken: () async {
      // 例: 認証リポジトリ等からトークン取得
      // final authRepository = ref.read(authRepositoryProvider);
      // return await authRepository.getToken();
      return null;
    },
  );
});
