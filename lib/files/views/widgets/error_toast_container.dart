import 'package:flutter/material.dart';
import '../../../core/app_color.dart';

/// アップロードエラー時に表示するトーストコンテナ。
///
/// Figma デザイン（node-id=244-415）に準拠し、
/// エラー用カラーや角丸、影、レイアウトを再現する。
class ErrorToastContainer extends StatelessWidget {
  /// 表示するエラーメッセージ。
  final String message;

  /// 閉じるボタンが押されたときのコールバック。
  final VoidCallback? onClose;

  /// [ErrorToastContainer] のコンストラクタ。
  const ErrorToastContainer({
    super.key,
    required this.message,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: AppColor.alart,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: onClose,
                child: const Icon(Icons.close, color: Colors.white, size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 