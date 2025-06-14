import 'package:flutter/material.dart';

import '../create_new_file_button.dart';
import 'user_info_widget.dart';

/// ファイル一覧画面のヘッダー部分を表示するウィジェット。
///
/// 新規ファイル作成ボタンとユーザー情報を横並びで表示する。
class FileListHeader extends StatelessWidget {
  /// 新規ファイル作成ボタン押下時のコールバック。
  final VoidCallback onCreateNewFile;

  /// ヘッダーの左右パディング。
  final double horizontalPadding;

  /// ユーザー名。
  final String userName;

  /// [FileListHeader] のインスタンスを生成する。
  const FileListHeader({
    super.key,
    required this.onCreateNewFile,
    required this.horizontalPadding,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CreateNewFileButton(
          onPressed: onCreateNewFile,
          horizontalPadding: horizontalPadding,
        ),
        UserInfoWidget(userName: userName),
      ],
    );
  }
}
