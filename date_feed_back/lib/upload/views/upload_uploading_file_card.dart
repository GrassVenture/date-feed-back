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

  /// [UploadUploadingFileCard] を生成する。
  const UploadUploadingFileCard({
    super.key,
    required this.fileName,
    required this.progress,
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
        ],
      ),
    );
  }
}
