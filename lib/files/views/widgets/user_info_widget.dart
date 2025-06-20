import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// ユーザー情報（アイコンと名前）を表示するウィジェット。
///
/// [userName] には表示するユーザー名を指定する。
class UserInfoWidget extends StatelessWidget {
  /// ユーザー名。
  final String userName;

  /// [UserInfoWidget] のインスタンスを生成する。
  const UserInfoWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFD9D9D9),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/person_icon.svg',
              width: 14,
              height: 14,
              colorFilter: const ColorFilter.mode(
                Color(0xFF645E6D),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          userName,
          style: const TextStyle(
            color: Color(0xFF2F2F2F),
            fontWeight: FontWeight.normal,
            fontSize: 14,
            fontFamily: 'Noto Sans JP',
          ),
        ),
      ],
    );
  }
}
