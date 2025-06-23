import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;

/// 音声ファイルの検証を行う UseCase。
class ValidateAudioFileUseCase {
  /// ファイル形式・長さの検証を行う。
  ///
  /// 検証に失敗した場合は [ValidateAudioFileException] を投げる。
  Future<void> call(html.File file) async {
    final fileName = file.name.toLowerCase();
    if (!(fileName.endsWith('.mp3') || fileName.endsWith('.wav'))) {
      throw ValidateAudioFileException('MP3 または WAV ファイルのみ対応しています。');
    }
    final audio = html.AudioElement();
    audio.src = html.Url.createObjectUrl(file);
    try {
      await audio.onLoadedMetadata.first;
    } catch (_) {
      throw ValidateAudioFileException('音声ファイルのメタデータ取得に失敗しました。');
    }
  }
}

/// 音声ファイル検証の例外。
class ValidateAudioFileException implements Exception {
  /// エラーメッセージ。
  final String message;

  /// [ValidateAudioFileException] のインスタンスを生成する。
  ValidateAudioFileException(this.message);
  @override
  String toString() => message;
}

/// [ValidateAudioFileUseCase] の Provider。
final validateAudioFileUseCaseProvider = Provider(
  (ref) => ValidateAudioFileUseCase(),
);
