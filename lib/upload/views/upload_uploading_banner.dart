import 'package:flutter/material.dart';

/// アップロード中のバナーを表示するウィジェット。
///
/// 1件のファイルをアップロード中であることを示す。
class UploadUploadingBanner extends StatelessWidget {
  /// アップロード進捗（0.0〜1.0）。
  final double? progress;

  /// 閉じるボタン押下時のコールバック。
  final VoidCallback? onClose;

  /// [UploadUploadingBanner] を生成する。
  const UploadUploadingBanner({
    super.key,
    this.progress,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Container(
        width: 482,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        decoration: const BoxDecoration(
          color: Color(0xFFE0CBFC),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFECECEC),
              offset: Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '1件のファイルをアップロード中です',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Color(0xFF2F2F2F),
              ),
            ),
            InkWell(
              onTap: onClose,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: Image.asset(
                      'assets/icons/close_icon_2.svg',
                      package: null,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
