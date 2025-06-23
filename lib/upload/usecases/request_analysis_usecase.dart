import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../analysis/services/analysis_service.dart';

/// 音声分析 API を呼び出す UseCase。
class RequestAnalysisUseCase {
  /// [AnalysisService]。
  final AnalysisService _analysisService;

  /// [RequestAnalysisUseCase] のインスタンスを生成する。
  RequestAnalysisUseCase(this._analysisService);

  /// 音声分析 API を呼び出す。
  ///
  /// 失敗した場合は [RequestAnalysisException] を投げる。
  Future<void> call({required String fileUri, required String userId}) async {
    try {
      await _analysisService.analyzeDateSession(
        fileUri: fileUri,
        userId: userId,
      );
    } catch (e) {
      throw RequestAnalysisException('音声分析に失敗しました: $e');
    }
  }
}

/// 音声分析 API 呼び出しの例外。
class RequestAnalysisException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [RequestAnalysisException] のインスタンスを生成する。
  RequestAnalysisException(this.message);
  @override
  String toString() => message;
}

/// [RequestAnalysisUseCase] の Provider。
final requestAnalysisUseCaseProvider = Provider((ref) {
  final analysisService = ref.read(analysisServiceProvider);
  return RequestAnalysisUseCase(analysisService);
});
