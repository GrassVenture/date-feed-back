import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'file_data.dart';

/// ファイル情報をカード形式で表示するウィジェット。
///
/// [file] には表示するファイルデータを指定する。
class FileCard extends StatelessWidget {
  /// 表示するファイルデータ。
  final FileData file;

  /// [FileCard] のインスタンスを生成する。
  const FileCard({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFECECEC),
            blurRadius: 8,
            offset: Offset(0, 2),
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'Noto Sans JP',
                  color: Color(0xFF645E6D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                '作成日:',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF645E6D),
                  fontFamily: 'Noto Sans JP',
                ),
              ),
              const SizedBox(width: 4),
              Text(
                file.date,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF645E6D),
                  fontFamily: 'Noto Sans JP',
                ),
              ),
              const SizedBox(width: 16),
              SvgPicture.asset(
                'assets/icons/play_circle_outline.svg',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF645E6D),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                file.time,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF645E6D),
                  fontFamily: 'Noto Sans JP',
                ),
              ),
              const SizedBox(width: 16),
              SvgPicture.asset(
                'assets/icons/person.svg',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF645E6D),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                file.user,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF645E6D),
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
