import 'dart:typed_data';

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

  /// Cloud Run API に音声分析をリクエストする。
  ///
  /// [fileUri] は Google Cloud Storage 上のファイル URI。
  /// [userId] はリクエストユーザーの ID。
  ///
  /// 成功時は API レスポンスの JSON マップを返す。
  /// 失敗時は例外をスローする。
  Future<Map<String, dynamic>> requestAudioAnalysis({
    required String fileUri,
    required String userId,
  }) async {
    try {
      final response = await dio.post(
        '/analyzeAudio',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {'file_uri': fileUri, 'user_id': userId},
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

  /// Google Cloud Storage への署名付き URL アップロード用のヘルパー。
  ///
  /// [signedUrl] はアップロード先の署名付き URL。
  /// [audioData] はアップロードする音声データ。
  /// [contentType] は Content-Type ヘッダー値。
  ///
  /// 成功時は何も返さない。失敗時は例外をスローする。
  Future<void> uploadToSignedUrl({
    required String signedUrl,
    required Uint8List audioData,
    required String contentType,
  }) async {
    try {
      final response = await dio.put(
        signedUrl,
        data: audioData,
        options: Options(headers: {'Content-Type': contentType}),
      );

      if (response.statusCode == 200) {
        logger.d('File upload successful');
      } else {
        logger.e('File upload failed: ${response.statusCode}');
        throw Exception('Upload failed: ${response.statusCode}');
      }
    } on DioException catch (error) {
      logger.e('DioException in file upload: ${error.message}');
      rethrow;
    }
  }
}
