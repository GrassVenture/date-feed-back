import 'package:flutter/material.dart';
import 'package:date_feed_back/core/app_color.dart';

import 'file_data.dart';

/// ファイル情報をカード形式で表示するウィジェット。
///
/// [file] には表示するファイルデータを指定する。
class FileCard extends StatelessWidget {
  /// 表示するファイルデータ。
  final FileData file;

  /// [FileCard] のインスタンスを生成する。
  const FileCard({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColor.grayMiddle,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 4),
              Text(
                file.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Noto Sans JP',
                  color: AppColor.textLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '作成日:',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.textLight,
                  fontFamily: 'Noto Sans JP',
                ),
              ),
              const SizedBox(width: 4),
              Text(
                file.date,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.textLight,
                  fontFamily: 'Noto Sans JP',
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.play_circle_outline,
                size: 16,
                color: AppColor.textLight,
              ),
              const SizedBox(width: 4),
              Text(
                file.time,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.textLight,
                  fontFamily: 'Noto Sans JP',
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.person,
                size: 16,
                color: AppColor.textLight,
              ),
              const SizedBox(width: 4),
              Text(
                file.user,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.textLight,
                  fontFamily: 'Noto Sans JP',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
