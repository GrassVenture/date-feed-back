// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_file_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AudioFileModel _$AudioFileModelFromJson(Map<String, dynamic> json) {
  return _AudioFileModel.fromJson(json);
}

/// @nodoc
mixin _$AudioFileModel {
  String get fileName => throw _privateConstructorUsedError;
  int get fileSize => throw _privateConstructorUsedError;
  String get fileExtension => throw _privateConstructorUsedError;
  List<int> get bytes => throw _privateConstructorUsedError; // ファイル本体
  UploadStatus get status => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError; // 0.0〜1.0
  String? get downloadUrl => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this AudioFileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AudioFileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioFileModelCopyWith<AudioFileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioFileModelCopyWith<$Res> {
  factory $AudioFileModelCopyWith(
          AudioFileModel value, $Res Function(AudioFileModel) then) =
      _$AudioFileModelCopyWithImpl<$Res, AudioFileModel>;
  @useResult
  $Res call(
      {String fileName,
      int fileSize,
      String fileExtension,
      List<int> bytes,
      UploadStatus status,
      double progress,
      String? downloadUrl,
      String? errorMessage});
}

/// @nodoc
class _$AudioFileModelCopyWithImpl<$Res, $Val extends AudioFileModel>
    implements $AudioFileModelCopyWith<$Res> {
  _$AudioFileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioFileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
    Object? fileSize = null,
    Object? fileExtension = null,
    Object? bytes = null,
    Object? status = null,
    Object? progress = null,
    Object? downloadUrl = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      fileSize: null == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int,
      fileExtension: null == fileExtension
          ? _value.fileExtension
          : fileExtension // ignore: cast_nullable_to_non_nullable
              as String,
      bytes: null == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UploadStatus,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioFileModelImplCopyWith<$Res>
    implements $AudioFileModelCopyWith<$Res> {
  factory _$$AudioFileModelImplCopyWith(_$AudioFileModelImpl value,
          $Res Function(_$AudioFileModelImpl) then) =
      __$$AudioFileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fileName,
      int fileSize,
      String fileExtension,
      List<int> bytes,
      UploadStatus status,
      double progress,
      String? downloadUrl,
      String? errorMessage});
}

/// @nodoc
class __$$AudioFileModelImplCopyWithImpl<$Res>
    extends _$AudioFileModelCopyWithImpl<$Res, _$AudioFileModelImpl>
    implements _$$AudioFileModelImplCopyWith<$Res> {
  __$$AudioFileModelImplCopyWithImpl(
      _$AudioFileModelImpl _value, $Res Function(_$AudioFileModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioFileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = null,
    Object? fileSize = null,
    Object? fileExtension = null,
    Object? bytes = null,
    Object? status = null,
    Object? progress = null,
    Object? downloadUrl = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AudioFileModelImpl(
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      fileSize: null == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int,
      fileExtension: null == fileExtension
          ? _value.fileExtension
          : fileExtension // ignore: cast_nullable_to_non_nullable
              as String,
      bytes: null == bytes
          ? _value._bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UploadStatus,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioFileModelImpl implements _AudioFileModel {
  const _$AudioFileModelImpl(
      {required this.fileName,
      required this.fileSize,
      required this.fileExtension,
      required final List<int> bytes,
      this.status = UploadStatus.initial,
      this.progress = 0,
      this.downloadUrl,
      this.errorMessage})
      : _bytes = bytes;

  factory _$AudioFileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioFileModelImplFromJson(json);

  @override
  final String fileName;
  @override
  final int fileSize;
  @override
  final String fileExtension;
  final List<int> _bytes;
  @override
  List<int> get bytes {
    if (_bytes is EqualUnmodifiableListView) return _bytes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bytes);
  }

// ファイル本体
  @override
  @JsonKey()
  final UploadStatus status;
  @override
  @JsonKey()
  final double progress;
// 0.0〜1.0
  @override
  final String? downloadUrl;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AudioFileModel(fileName: $fileName, fileSize: $fileSize, fileExtension: $fileExtension, bytes: $bytes, status: $status, progress: $progress, downloadUrl: $downloadUrl, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioFileModelImpl &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.fileExtension, fileExtension) ||
                other.fileExtension == fileExtension) &&
            const DeepCollectionEquality().equals(other._bytes, _bytes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fileName,
      fileSize,
      fileExtension,
      const DeepCollectionEquality().hash(_bytes),
      status,
      progress,
      downloadUrl,
      errorMessage);

  /// Create a copy of AudioFileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioFileModelImplCopyWith<_$AudioFileModelImpl> get copyWith =>
      __$$AudioFileModelImplCopyWithImpl<_$AudioFileModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioFileModelImplToJson(
      this,
    );
  }
}

abstract class _AudioFileModel implements AudioFileModel {
  const factory _AudioFileModel(
      {required final String fileName,
      required final int fileSize,
      required final String fileExtension,
      required final List<int> bytes,
      final UploadStatus status,
      final double progress,
      final String? downloadUrl,
      final String? errorMessage}) = _$AudioFileModelImpl;

  factory _AudioFileModel.fromJson(Map<String, dynamic> json) =
      _$AudioFileModelImpl.fromJson;

  @override
  String get fileName;
  @override
  int get fileSize;
  @override
  String get fileExtension;
  @override
  List<int> get bytes; // ファイル本体
  @override
  UploadStatus get status;
  @override
  double get progress; // 0.0〜1.0
  @override
  String? get downloadUrl;
  @override
  String? get errorMessage;

  /// Create a copy of AudioFileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioFileModelImplCopyWith<_$AudioFileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
