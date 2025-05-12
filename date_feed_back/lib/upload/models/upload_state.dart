import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_state.freezed.dart';

@freezed
class UploadState with _$UploadState {
  const factory UploadState({
    @Default(false) bool isUploading,
    String? error,
    @Default(0.0) double progress,
  }) = _UploadState;
}
