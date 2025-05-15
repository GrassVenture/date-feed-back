import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_file_model.freezed.dart';
part 'audio_file_model.g.dart';

enum UploadStatus {
  initial,
  uploading,
  success,
  failure,
}

@freezed
class AudioFileModel with _$AudioFileModel {
  const factory AudioFileModel({
    required String fileName,
    required int fileSize,
    required String fileExtension,
    required List<int> bytes, // ファイル本体
    @Default(UploadStatus.initial) UploadStatus status,
    @Default(0) double progress, // 0.0〜1.0
    String? downloadUrl,
    String? errorMessage,
  }) = _AudioFileModel;

  factory AudioFileModel.fromJson(Map<String, dynamic> json) =>
      _$AudioFileModelFromJson(json);
}
