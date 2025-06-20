import 'package:flutter/material.dart';
import 'package:date_feed_back/core/app_color.dart';

import 'progress_indicator.dart';

/// ファイル情報とアップロード進捗を表示する行ウィジェット。
///
/// ファイルアイコン、ファイル名、および進捗インジケーターを含む。
class FileInfoRow extends StatelessWidget {
  /// アップロード中のファイル名。
  final String fileName;

  /// アップロード進行度（0.0〜1.0）。
  final double progress;

  /// [FileInfoRow] のコンストラクタ。
  const FileInfoRow({
    super.key,
    required this.fileName,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
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
              color: Colors.white,
              shape: BoxShape.rectangle,
            ),
            child: Icon(Icons.audio_file,
                size: 32, color: AppColor.main),
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
          ProgressIndicatorWidget(progress: progress),
        ],
      ),
    );
  }
}
