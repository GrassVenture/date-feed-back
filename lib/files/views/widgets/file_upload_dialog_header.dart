import 'package:flutter/material.dart';

import '../../../core/app_color.dart';

/// ファイルアップロードダイアログのヘッダー部分。
///
/// タイトルと閉じるボタンを表示する。
class FileUploadDialogHeader extends StatelessWidget {
  /// ダイアログのタイトル。
  final String title;

  /// 閉じるボタンが押されたときのコールバック。
  final VoidCallback? onClose;

  /// [FileUploadDialogHeader] のコンストラクタ。
  const FileUploadDialogHeader({
    super.key,
    required this.title,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 28),
      decoration: BoxDecoration(
        color: AppColor.grayLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColor.textBlack,
            ),
          ),
          InkWell(
            onTap: onClose,
            borderRadius: BorderRadius.circular(12),
            child: Icon(Icons.close, size: 24, color: AppColor.textBlack),
          ),
        ],
      ),
    );
  }
}
