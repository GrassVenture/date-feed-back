// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DateSession _$DateSessionFromJson(Map<String, dynamic> json) {
  return _DateSession.fromJson(json);
}

/// @nodoc
mixin _$DateSession {
  /// ファイル名。
  String get title => throw _privateConstructorUsedError;

  /// 作成日時。
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 音声ファイルの長さ（秒）。
  int get durationSeconds => throw _privateConstructorUsedError;

  /// ユーザー名。
  String get user => throw _privateConstructorUsedError;

  /// Serializes this DateSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DateSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DateSessionCopyWith<DateSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateSessionCopyWith<$Res> {
  factory $DateSessionCopyWith(
          DateSession value, $Res Function(DateSession) then) =
      _$DateSessionCopyWithImpl<$Res, DateSession>;
  @useResult
  $Res call(
      {String title,
      @TimestampConverter() DateTime createdAt,
      int durationSeconds,
      String user});
}

/// @nodoc
class _$DateSessionCopyWithImpl<$Res, $Val extends DateSession>
    implements $DateSessionCopyWith<$Res> {
  _$DateSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DateSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? createdAt = null,
    Object? durationSeconds = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DateSessionImplCopyWith<$Res>
    implements $DateSessionCopyWith<$Res> {
  factory _$$DateSessionImplCopyWith(
          _$DateSessionImpl value, $Res Function(_$DateSessionImpl) then) =
      __$$DateSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      @TimestampConverter() DateTime createdAt,
      int durationSeconds,
      String user});
}

/// @nodoc
class __$$DateSessionImplCopyWithImpl<$Res>
    extends _$DateSessionCopyWithImpl<$Res, _$DateSessionImpl>
    implements _$$DateSessionImplCopyWith<$Res> {
  __$$DateSessionImplCopyWithImpl(
      _$DateSessionImpl _value, $Res Function(_$DateSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of DateSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? createdAt = null,
    Object? durationSeconds = null,
    Object? user = null,
  }) {
    return _then(_$DateSessionImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DateSessionImpl implements _DateSession {
  const _$DateSessionImpl(
      {required this.title,
      @TimestampConverter() required this.createdAt,
      required this.durationSeconds,
      required this.user});

  factory _$DateSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateSessionImplFromJson(json);

  /// ファイル名。
  @override
  final String title;

  /// 作成日時。
  @override
  @TimestampConverter()
  final DateTime createdAt;

  /// 音声ファイルの長さ（秒）。
  @override
  final int durationSeconds;

  /// ユーザー名。
  @override
  final String user;

  @override
  String toString() {
    return 'DateSession(title: $title, createdAt: $createdAt, durationSeconds: $durationSeconds, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateSessionImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, createdAt, durationSeconds, user);

  /// Create a copy of DateSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateSessionImplCopyWith<_$DateSessionImpl> get copyWith =>
      __$$DateSessionImplCopyWithImpl<_$DateSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateSessionImplToJson(
      this,
    );
  }
}

abstract class _DateSession implements DateSession {
  const factory _DateSession(
      {required final String title,
      @TimestampConverter() required final DateTime createdAt,
      required final int durationSeconds,
      required final String user}) = _$DateSessionImpl;

  factory _DateSession.fromJson(Map<String, dynamic> json) =
      _$DateSessionImpl.fromJson;

  /// ファイル名。
  @override
  String get title;

  /// 作成日時。
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// 音声ファイルの長さ（秒）。
  @override
  int get durationSeconds;

  /// ユーザー名。
  @override
  String get user;

  /// Create a copy of DateSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateSessionImplCopyWith<_$DateSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
