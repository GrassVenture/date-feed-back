import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roggle/roggle.dart';

import '../../analysis/services/analysis_service.dart';
import 'request_analysis_exception.dart';

/// 音声分析 API を呼び出す UseCase の Provider。
///
/// [RequestAnalysisUseCase] のインスタンスを提供する。
final requestAnalysisUseCaseProvider = Provider((ref) {
  final analysisService = ref.read(analysisServiceProvider);
  return RequestAnalysisUseCase(analysisService);
});

/// 音声分析 API を呼び出すクラス。
///
/// 指定したファイル URI とユーザー ID で音声分析 API を呼び出す。
class RequestAnalysisUseCase {
  /// [AnalysisService] のインスタンス。
  final AnalysisService analysisService;

  /// ロガー。
  final Roggle logger;

  /// [RequestAnalysisUseCase] のインスタンスを生成する。
  ///
  /// [analysisService] 音声分析サービス。
  /// [logger] を省略した場合はデフォルトの [Roggle] を利用する。
  RequestAnalysisUseCase(this.analysisService, {Roggle? logger})
    : logger = logger ?? Roggle();

  /// 音声分析 API を呼び出す。
  ///
  /// 失敗した場合は [RequestAnalysisException] を投げる。
  ///
  /// [fileUri] 分析対象ファイルの URI。
  /// [userId] ユーザー ID。
  Future<void> call({required String fileUri, required String userId}) async {
    try {
      await analysisService.analyzeDateSession(
        fileUri: fileUri,
        userId: userId,
      );
    } catch (e) {
      logger.e('音声分析 API 呼び出しに失敗: $e');
      throw RequestAnalysisException('音声分析 API 呼び出しに失敗しました。');
    }
  }
}
