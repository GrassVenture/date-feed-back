import 'package:flutter/material.dart';

import '../../../core/app_color.dart';

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
            child: Icon(
              Icons.person,
              size: 14,
              color: AppColor.textLight,
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
