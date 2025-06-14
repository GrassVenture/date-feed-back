import 'package:flutter/material.dart';

/// ファイルアップロード進行状況を表示するダイアログ。
///
/// Figma デザイン（file_upload_dialog_coontainer）に基づき、
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
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFECECEC),
              offset: Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ヘッダー
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 28),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F4F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: const Icon(Icons.close,
                        size: 24, color: Color(0xFF2F2F2F)),
                  ),
                ],
              ),
            ),
            // 本体
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ファイルアイコン
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      shape: BoxShape.rectangle,
                    ),
                    child: const Icon(Icons.audio_file,
                        size: 32, color: Color(0xFF9B6ADF)),
                  ),
                  const SizedBox(width: 16),
                  // ファイル名
                  Expanded(
                    child: Text(
                      fileName,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 32),
                  // プログレスサークル
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 6,
                            backgroundColor: const Color(0xFFECECEC),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF9B6ADF)),
                          ),
                        ),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xFF9B6ADF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
