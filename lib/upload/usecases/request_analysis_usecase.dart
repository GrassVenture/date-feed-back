import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roggle/roggle.dart';

import '../../analysis/services/analysis_service.dart';
import 'request_analysis_exception.dart';

/// [RequestAnalysisUseCase] の Provider。
final requestAnalysisUseCaseProvider = Provider((ref) {
  final analysisService = ref.read(analysisServiceProvider);
  return RequestAnalysisUseCase(analysisService);
});

/// 音声分析 API を呼び出す UseCase。
class RequestAnalysisUseCase {
  /// [AnalysisService]。
  final AnalysisService _analysisService;

  /// ロガー。
  final Roggle logger;

  /// [RequestAnalysisUseCase] のインスタンスを生成する。
  RequestAnalysisUseCase(this._analysisService, {Roggle? logger})
    : logger = logger ?? Roggle();

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
      logger.e('音声分析 API 呼び出しに失敗: $e');
      throw RequestAnalysisException('音声分析 API 呼び出しに失敗しました。');
    }
  }
}
