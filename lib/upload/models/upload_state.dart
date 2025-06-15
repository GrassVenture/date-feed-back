import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_state.freezed.dart';

enum UploadStatus {
  initial,
  uploading,
  success,
  failure,
}

@freezed
class UploadState with _$UploadState {
  const factory UploadState({
    @Default(false) bool isUploading,
    String? error,
    @Default(0.0) double progress,
    String? fileName,
    int? fileSize,
    String? downloadUrl,
    @Default(UploadStatus.initial) UploadStatus status,
    Uint8List? bytes,
  }) = _UploadState;
}
