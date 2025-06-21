import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_session.freezed.dart';
part 'date_session.g.dart';

/// ファイル情報を表すデータクラス。
///
/// ファイル名、作成日、作成時刻、ユーザー名を保持する。
@freezed
class DateSession with _$DateSession {
  /// [DateSession] のインスタンスを生成する。
  const factory DateSession({
    /// ファイル名。
    required String title,

    /// 作成日（例: 2025/05/15）。
    required String date,

    /// 作成時刻（例: 12:50）。
    required String time,

    /// ユーザー名。
    required String user,
  }) = _DateSession;

  /// JSON から [DateSession] インスタンスを生成する。
  factory DateSession.fromJson(Map<String, dynamic> json) =>
      _$DateSessionFromJson(json);
}
