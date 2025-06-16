// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudioFileModelImpl _$$AudioFileModelImplFromJson(Map<String, dynamic> json) =>
    _$AudioFileModelImpl(
      fileName: json['fileName'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      fileExtension: json['fileExtension'] as String,
      bytes: (json['bytes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      status: $enumDecodeNullable(_$UploadStatusEnumMap, json['status']) ??
          UploadStatus.initial,
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
      downloadUrl: json['downloadUrl'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$AudioFileModelImplToJson(
        _$AudioFileModelImpl instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'fileSize': instance.fileSize,
      'fileExtension': instance.fileExtension,
      'bytes': instance.bytes,
      'status': _$UploadStatusEnumMap[instance.status]!,
      'progress': instance.progress,
      'downloadUrl': instance.downloadUrl,
      'errorMessage': instance.errorMessage,
    };

const _$UploadStatusEnumMap = {
  UploadStatus.initial: 'initial',
  UploadStatus.uploading: 'uploading',
  UploadStatus.success: 'success',
  UploadStatus.failure: 'failure',
};
