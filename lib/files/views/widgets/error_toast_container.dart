import 'package:flutter/material.dart';
import '../../../core/app_color.dart';

/// アップロードエラー時に表示するトーストコンテナ。
///
/// Figma デザイン（node-id=244-415）に準拠し、
/// エラー用カラーやアイコン、角丸、影、レイアウトを再現する。
class ErrorToastContainer extends StatelessWidget {
  /// 表示するエラーメッセージ。
  final String message;

  /// [ErrorToastContainer] のコンストラクタ。
  const ErrorToastContainer({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColor.grayMiddle.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColor.alart, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: AppColor.alart, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: AppColor.textBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 