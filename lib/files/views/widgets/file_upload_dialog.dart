import 'package:flutter/material.dart';
import 'package:date_feed_back/core/app_color.dart';

import 'file_info_row.dart';
import 'file_upload_dialog_header.dart';

/// ファイルアップロード進行状況を表示するダイアログ。
///
/// Figma デザインに基づき、
/// 配色・角丸・影・レイアウト・テキスト等を再現する。
class FileUploadDialog extends StatelessWidget {
  /// アップロード中のファイル名。
  final String fileName;

  /// アップロード進行度（0.0〜1.0）。
  final double progress;

  /// アップロードキャンセル時のコールバック。
  final VoidCallback? onClose;

  /// コンストラクタ。
  const FileUploadDialog({
    super.key,
    required this.fileName,
    required this.progress,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 498,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColor.grayMiddle,
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ヘッダー
            FileUploadDialogHeader(
              title: '1件のファイルをアップロード中です',
              onClose: onClose,
            ),
            // 本体
            FileInfoRow(
              fileName: fileName,
              progress: progress,
            ),
          ],
        ),
      ),
    );
  }
}
