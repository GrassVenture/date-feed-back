import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_state.freezed.dart';

/// アップロード処理の状態を表す列挙型。
enum UploadStatus { initial, uploading, success, failure }

/// 音声ファイルのアップロード状態を管理するクラス。
///
/// 進捗やエラー、ダウンロード URL、分析セッション ID などを保持する。
@freezed
class UploadState with _$UploadState {
  /// [UploadState] を生成する。
  ///
  /// [isUploading] はアップロード中かどうか、[error] はエラーメッセージ、[progress] は進捗率、
  /// [fileName] はファイル名、[fileSize] はファイルサイズ、[downloadUrl] はダウンロード URL、
  /// [status] はアップロード状態、[bytes] はファイルのバイト列、[analysisSessionId] は音声分析セッション ID を表す。
  const factory UploadState({
    @Default(false) bool isUploading,
    String? error,
    @Default(0.0) double progress,
    String? fileName,
    int? fileSize,
    String? downloadUrl,
    @Default(UploadStatus.initial) UploadStatus status,
    Uint8List? bytes,
    String? analysisSessionId,
  }) = _UploadState;
}
