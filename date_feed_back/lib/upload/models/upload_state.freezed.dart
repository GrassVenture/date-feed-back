// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UploadState {
  bool get isUploading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  int? get fileSize => throw _privateConstructorUsedError;
  String? get downloadUrl => throw _privateConstructorUsedError;
  UploadStatus get status => throw _privateConstructorUsedError;
  Uint8List? get bytes => throw _privateConstructorUsedError;

  /// Create a copy of UploadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UploadStateCopyWith<UploadState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadStateCopyWith<$Res> {
  factory $UploadStateCopyWith(
          UploadState value, $Res Function(UploadState) then) =
      _$UploadStateCopyWithImpl<$Res, UploadState>;
  @useResult
  $Res call(
      {bool isUploading,
      String? error,
      double progress,
      String? fileName,
      int? fileSize,
      String? downloadUrl,
      UploadStatus status,
      Uint8List? bytes});
}

/// @nodoc
class _$UploadStateCopyWithImpl<$Res, $Val extends UploadState>
    implements $UploadStateCopyWith<$Res> {
  _$UploadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UploadState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isUploading = null,
    Object? error = freezed,
    Object? progress = null,
    Object? fileName = freezed,
    Object? fileSize = freezed,
    Object? downloadUrl = freezed,
    Object? status = null,
    Object? bytes = freezed,
  }) {
    return _then(_value.copyWith(
      isUploading: null == isUploading
          ? _value.isUploading
          : isUploading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UploadStatus,
      bytes: freezed == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UploadStateImplCopyWith<$Res>
    implements $UploadStateCopyWith<$Res> {
  factory _$$UploadStateImplCopyWith(
          _$UploadStateImpl value, $Res Function(_$UploadStateImpl) then) =
      __$$UploadStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isUploading,
      String? error,
      double progress,
      String? fileName,
      int? fileSize,
      String? downloadUrl,
      UploadStatus status,
      Uint8List? bytes});
}

/// @nodoc
class __$$UploadStateImplCopyWithImpl<$Res>
    extends _$UploadStateCopyWithImpl<$Res, _$UploadStateImpl>
    implements _$$UploadStateImplCopyWith<$Res> {
  __$$UploadStateImplCopyWithImpl(
      _$UploadStateImpl _value, $Res Function(_$UploadStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isUploading = null,
    Object? error = freezed,
    Object? progress = null,
    Object? fileName = freezed,
    Object? fileSize = freezed,
    Object? downloadUrl = freezed,
    Object? status = null,
    Object? bytes = freezed,
  }) {
    return _then(_$UploadStateImpl(
      isUploading: null == isUploading
          ? _value.isUploading
          : isUploading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UploadStatus,
      bytes: freezed == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$UploadStateImpl with DiagnosticableTreeMixin implements _UploadState {
  const _$UploadStateImpl(
      {this.isUploading = false,
      this.error,
      this.progress = 0.0,
      this.fileName,
      this.fileSize,
      this.downloadUrl,
      this.status = UploadStatus.initial,
      this.bytes});

  @override
  @JsonKey()
  final bool isUploading;
  @override
  final String? error;
  @override
  @JsonKey()
  final double progress;
  @override
  final String? fileName;
  @override
  final int? fileSize;
  @override
  final String? downloadUrl;
  @override
  @JsonKey()
  final UploadStatus status;
  @override
  final Uint8List? bytes;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UploadState(isUploading: $isUploading, error: $error, progress: $progress, fileName: $fileName, fileSize: $fileSize, downloadUrl: $downloadUrl, status: $status, bytes: $bytes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UploadState'))
      ..add(DiagnosticsProperty('isUploading', isUploading))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('progress', progress))
      ..add(DiagnosticsProperty('fileName', fileName))
      ..add(DiagnosticsProperty('fileSize', fileSize))
      ..add(DiagnosticsProperty('downloadUrl', downloadUrl))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('bytes', bytes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadStateImpl &&
            (identical(other.isUploading, isUploading) ||
                other.isUploading == isUploading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.bytes, bytes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isUploading,
      error,
      progress,
      fileName,
      fileSize,
      downloadUrl,
      status,
      const DeepCollectionEquality().hash(bytes));

  /// Create a copy of UploadState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadStateImplCopyWith<_$UploadStateImpl> get copyWith =>
      __$$UploadStateImplCopyWithImpl<_$UploadStateImpl>(this, _$identity);
}

abstract class _UploadState implements UploadState {
  const factory _UploadState(
      {final bool isUploading,
      final String? error,
      final double progress,
      final String? fileName,
      final int? fileSize,
      final String? downloadUrl,
      final UploadStatus status,
      final Uint8List? bytes}) = _$UploadStateImpl;

  @override
  bool get isUploading;
  @override
  String? get error;
  @override
  double get progress;
  @override
  String? get fileName;
  @override
  int? get fileSize;
  @override
  String? get downloadUrl;
  @override
  UploadStatus get status;
  @override
  Uint8List? get bytes;

  /// Create a copy of UploadState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadStateImplCopyWith<_$UploadStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
