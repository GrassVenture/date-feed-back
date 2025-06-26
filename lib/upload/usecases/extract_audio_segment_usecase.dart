import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roggle/roggle.dart';
import 'package:universal_html/html.dart' as html;

import 'extract_audio_segment_exception.dart';

/// 音声ファイルから 15 分以内のセグメントを抽出する UseCase の Provider。
///
/// [ExtractAudioSegmentUseCase] のインスタンスを提供する。
final extractAudioSegmentUseCaseProvider = Provider.autoDispose(
  (ref) => ExtractAudioSegmentUseCase(),
);

/// 音声ファイルから 15 分以内のセグメントを抽出するクラス。
///
/// 15 分を超える場合は冒頭 15 分のバイト数でスライスしたファイルを返す。
class ExtractAudioSegmentUseCase {
  /// ロガーインスタンス。
  final Roggle logger;

  /// [ExtractAudioSegmentUseCase] のインスタンスを生成する。
  ///
  /// [logger] を省略した場合はデフォルトの [Roggle] を利用する。
  ExtractAudioSegmentUseCase({Roggle? logger}) : logger = logger ?? Roggle();

  /// 15 分を超える場合は冒頭 15 分分のバイト数でスライスしたファイルを返す。
  ///
  /// 15 分以内の場合は元のファイルを返す。
  ///
  /// 抽出に失敗した場合は [ExtractAudioSegmentException] を投げる。
  ///
  /// [file] 対象の音声ファイル。
  /// [duration] 音声ファイルの長さ（秒）。
  ///
  /// 戻り値は抽出後の [html.Blob]。
  Future<html.Blob> call(html.File file, double duration) async {
    const maxDurationSec = 15 * 60;
    if (duration <= maxDurationSec) {
      return file;
    }
    try {
      final maxBytes = (file.size * (maxDurationSec / duration)).floor();
      return file.slice(0, maxBytes, file.type);
    } catch (e) {
      logger.e('音声ファイルの 15 分抽出に失敗: $e');
      throw ExtractAudioSegmentException('音声ファイルの 15 分抽出に失敗しました。');
    }
  }
}
