import 'package:flutter/material.dart';
import '../../../core/app_color.dart';

/// アップロードキャンセルアラートダイアログ。
///
/// Figmaデザイン（node-id=221-508）に準拠。
class AlartDialog extends StatelessWidget {
  /// キャンセル確定時のコールバック。
  final VoidCallback onCancelConfirmed;

  /// [AlartDialog] のコンストラクタ。
  const AlartDialog({
    super.key,
    required this.onCancelConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 320, // 最小幅
          maxWidth: 400, // 最大幅（画像例に近い）
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
          child: Stack(
            children: [
              // 本体
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'アップロードをやめますか？',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.alart,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
                      child: const Text('アップロードをやめる'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'アップロードを続行',
                      style: TextStyle(
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
                top: 0,
                right: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.of(context).pop(),
                  child:  Padding(
                    padding: EdgeInsets.all(4.0),
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