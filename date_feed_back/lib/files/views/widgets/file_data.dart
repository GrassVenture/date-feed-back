import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_data.freezed.dart';
part 'file_data.g.dart';

/// ファイル情報を表すデータクラス。
///
/// ファイル名、作成日、作成時刻、ユーザー名を保持する。
@freezed
class FileData with _$FileData {
  /// [FileData] のインスタンスを生成する。
  const factory FileData({
    /// ファイル名。
    required String title,

    /// 作成日（例: 2025/05/15）。
    required String date,

    /// 作成時刻（例: 12:50）。
    required String time,

    /// ユーザー名。
    required String user,
  }) = _FileData;

  /// JSON から [FileData] インスタンスを生成する。
  factory FileData.fromJson(Map<String, dynamic> json) =>
      _$FileDataFromJson(json);
}
