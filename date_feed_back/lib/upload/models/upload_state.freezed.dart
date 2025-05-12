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
  $Res call({bool isUploading, String? error, double progress});
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
  $Res call({bool isUploading, String? error, double progress});
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
    ));
  }
}

/// @nodoc

class _$UploadStateImpl implements _UploadState {
  const _$UploadStateImpl(
      {this.isUploading = false, this.error, this.progress = 0.0});

  @override
  @JsonKey()
  final bool isUploading;
  @override
  final String? error;
  @override
  @JsonKey()
  final double progress;

  @override
  String toString() {
    return 'UploadState(isUploading: $isUploading, error: $error, progress: $progress)';
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
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isUploading, error, progress);

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
      final double progress}) = _$UploadStateImpl;

  @override
  bool get isUploading;
  @override
  String? get error;
  @override
  double get progress;

  /// Create a copy of UploadState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadStateImplCopyWith<_$UploadStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
