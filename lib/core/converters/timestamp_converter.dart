import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Firestore の [Timestamp] と Dart の [DateTime] を相互に変換するコンバーター。
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  /// [TimestampConverter] のインスタンスを生成する。
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
