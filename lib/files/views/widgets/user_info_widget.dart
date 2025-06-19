import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:date_feed_back/core/app_color.dart';

/// ユーザー情報（アイコンと名前）を表示するウィジェット。
///
/// [userName] には表示するユーザー名を指定する。
class UserInfoWidget extends StatelessWidget {
  /// ユーザー名。
  final String userName;

  /// [UserInfoWidget] のインスタンスを生成する。
  const UserInfoWidget({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColor.grayMiddle,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/person_icon2.svg',
              width: 14,
              height: 14,
              colorFilter:
                  ColorFilter.mode(AppColor.textLight, BlendMode.srcIn),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          userName,
          style: TextStyle(
            color: AppColor.textBlack,
            fontWeight: FontWeight.normal,
            fontSize: 14,
            fontFamily: 'Noto Sans JP',
          ),
        ),
      ],
    );
  }
}
