import 'package:flutter/material.dart';
import '../../../core/app_color.dart';

/// カスタムアラートダイアログ。
///
/// [titleText] でタイトル、[cancelButtonText] でキャンセルボタン、[continueText] で続行テキストを指定する。
/// Figmaデザイン（node-id=221-508）に準拠。
class CustomAlertDialog extends StatelessWidget {
  /// キャンセル確定時のコールバック。
  final VoidCallback onCancelConfirmed;

  /// ダイアログのタイトルテキスト。
  final String titleText;

  /// キャンセルボタンのテキスト。
  final String cancelButtonText;

  /// 続行テキスト。
  final String continueText;

  /// [CustomAlertDialog] のコンストラクタ。
  ///
  /// [titleText] でタイトル、[cancelButtonText] でキャンセルボタン、[continueText] で続行テキストを指定する。
  const CustomAlertDialog({
    super.key,
    required this.onCancelConfirmed,
    required this.titleText,
    required this.cancelButtonText,
    required this.continueText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 320,
          maxWidth: 400, 
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 本体
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      titleText,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.alert,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onCancelConfirmed();
                      },
                      child: Text(cancelButtonText),
                    ),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      continueText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.gray,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              // バツボタン（右上）
              Positioned(
                top: -16,
                right: -16,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(Icons.close, size: 28, color: AppColor.textBlack),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 