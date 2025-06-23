// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DateSessionImpl _$$DateSessionImplFromJson(Map<String, dynamic> json) =>
    _$DateSessionImpl(
      title: json['title'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      user: json['user'] as String,
    );

Map<String, dynamic> _$$DateSessionImplToJson(_$DateSessionImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'durationSeconds': instance.durationSeconds,
      'user': instance.user,
    };
