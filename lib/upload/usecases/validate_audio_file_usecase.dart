import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;
import 'package:roggle/roggle.dart';

import 'validate_audio_file_exception.dart';

/// 音声ファイルの検証と長さ取得を行う UseCase の Provider。
///
/// [ValidateAudioFileUseCase] のインスタンスを提供する。
final validateAudioFileUseCaseProvider = Provider(
  (ref) => ValidateAudioFileUseCase(),
);

/// 音声ファイルの検証と長さ取得を行うクラス。
///
/// ファイル形式や長さの検証を行い、音声長（秒）を取得する。
class ValidateAudioFileUseCase {
  /// ロガーインスタンス。
  final Roggle logger;

  /// [ValidateAudioFileUseCase] のインスタンスを生成する。
  ///
  /// [logger] を省略した場合はデフォルトの [Roggle] を利用する。
  ValidateAudioFileUseCase({Roggle? logger}) : logger = logger ?? Roggle();

  /// ファイル形式・長さの検証を行い、音声長（秒）を返す。
  ///
  /// 検証に失敗した場合は [ValidateAudioFileException] を投げる。
  ///
  /// [file] 検証対象の音声ファイル。
  ///
  /// 戻り値は音声ファイルの長さ（秒）。
  Future<double> call(html.File file) async {
    final fileName = file.name.toLowerCase();
    if (!(fileName.endsWith('.mp3') || fileName.endsWith('.wav'))) {
      logger.w('不正なファイル形式: $fileName');
      throw ValidateAudioFileException('MP3 または WAV ファイルのみ対応しています。');
    }
    final audio = html.AudioElement();
    audio.src = html.Url.createObjectUrl(file);
    try {
      await audio.onLoadedMetadata.first;
      if (audio.duration.isNaN || audio.duration <= 0) {
        logger.w('音声長が取得できない: $fileName');
        throw ValidateAudioFileException('音声ファイルの長さ取得に失敗しました。');
      }
      return audio.duration.toDouble();
    } catch (e) {
      logger.e('音声ファイルのメタデータ取得に失敗: $e');
      throw ValidateAudioFileException('音声ファイルのメタデータ取得に失敗しました。');
    }
  }
}
