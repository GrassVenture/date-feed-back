/// ファイル情報を表すデータクラス。
///
/// ファイル名、作成日、作成時刻、ユーザー名を保持する。
class FileData {
  /// ファイル名。
  final String title;

  /// 作成日（例: 2025/05/15）。
  final String date;

  /// 作成時刻（例: 12:50）。
  final String time;

  /// ユーザー名。
  final String user;

  /// [FileData] のインスタンスを生成する。
  const FileData({
    required this.title,
    required this.date,
    required this.time,
    required this.user,
  });
}
