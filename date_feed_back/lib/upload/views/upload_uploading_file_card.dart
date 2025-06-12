import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// アップロード中のファイル情報を表示するカードウィジェット。
///
/// ファイル名、アイコン、進捗サークルを表示する。
class UploadUploadingFileCard extends StatelessWidget {
  /// 表示するファイル名。
  final String fileName;

  /// アップロード進捗（0.0〜1.0）。
  final double progress;

  /// ファイルサイズ（バイト単位）。
  final int? fileSize;

  /// キャンセルボタン押下時のコールバック。
  final VoidCallback? onCancel;

  /// [UploadUploadingFileCard] を生成する。
  const UploadUploadingFileCard({
    super.key,
    required this.fileName,
    required this.progress,
    this.fileSize,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFECECEC),
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Audio アイコン
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF9B6ADF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SvgPicture.asset(
                'assets/icons/audio_icon.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // ファイル名とサイズ
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (fileSize != null)
                  Text(
                    _formatFileSize(fileSize!),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF645E6D),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // 進捗サークル
          SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6,
                    backgroundColor: const Color(0xFFE0CBFC),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFF9B6ADF)),
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // キャンセルボタン（オプション）
          if (onCancel != null) ...[
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.close, color: Color(0xFF9B6ADF)),
              onPressed: onCancel,
              tooltip: 'アップロードをキャンセル',
            ),
          ],
        ],
      ),
    );
  }

  /// ファイルサイズを人間が読みやすい形式に変換する。
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
