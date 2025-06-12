import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      color: const Color(0xFF3C1A6C),
      child: Column(
        children: [
          const SizedBox(height: 20),

          /// ホームアイコン（中央寄せ・白色）
          SvgPicture.asset(
            'assets/icons/home_icon.svg',
            width: 32,
            height: 32,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
