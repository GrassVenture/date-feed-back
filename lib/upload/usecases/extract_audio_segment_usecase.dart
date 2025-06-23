import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;

/// 音声ファイルから 15 分以内のセグメントを抽出する UseCase。
class ExtractAudioSegmentUseCase {
  /// 15 分を超える場合は冒頭 15 分分のバイト数でスライスしたファイルを返す。
  ///
  /// 15 分以内の場合は元のファイルを返す。
  ///
  /// 抽出に失敗した場合は [ExtractAudioSegmentException] を投げる。
  Future<html.Blob> call(html.File file, double duration) async {
    const maxDurationSec = 15 * 60;
    if (duration <= maxDurationSec) {
      return file;
    }
    try {
      final maxBytes = (file.size * (maxDurationSec / duration)).floor();
      return file.slice(0, maxBytes, file.type);
    } catch (e) {
      throw ExtractAudioSegmentException('音声ファイルの 15 分抽出に失敗しました。');
    }
  }
}

/// 音声セグメント抽出の例外。
class ExtractAudioSegmentException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [ExtractAudioSegmentException] のインスタンスを生成する。
  ExtractAudioSegmentException(this.message);
  @override
  String toString() => message;
}

/// [ExtractAudioSegmentUseCase] の Provider。
final extractAudioSegmentUseCaseProvider = Provider(
  (ref) => ExtractAudioSegmentUseCase(),
);
