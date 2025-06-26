import 'package:flutter/material.dart';

import '../../core/app_color.dart';

/// アプリケーションの左サイドバーを表示するウィジェット。
///
/// 背景色は濃いパープル（#3C1A6C）で、上部に白いホームアイコンを表示する。
/// 今後、メニュー項目を追加する際の土台として利用できる。
class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: AppColor.mainDark,
      child: const Column(
        children: [
          SizedBox(height: 20),

          /// ホームアイコン（中央寄せ・白色）
          Icon(
            Icons.home,
            size: 32,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
