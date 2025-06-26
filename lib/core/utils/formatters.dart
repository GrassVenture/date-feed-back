import 'package:intl/intl.dart';

/// [DateTime] を拡張し、日付関連のフォーマット機能を提供する。
extension DateTimeFormat on DateTime {
  /// [DateTime] を `yyyy/MM/dd` 形式の文字列に変換する。
  String toJapaneseDate() {
    final formatter = DateFormat('yyyy/MM/dd');
    return formatter.format(this);
  }
}

/// `int` 型を拡張し、時間関連のフォーマット機能を提供する拡張。
extension DurationFormatter on int {
  /// 秒数を `MM:SS` 形式の文字列に変換する。
  ///
  /// ```dart
  /// final seconds = 70;
  /// print(seconds.toMMSS()); // 01:10
  /// ```
  String toMMSS() {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
