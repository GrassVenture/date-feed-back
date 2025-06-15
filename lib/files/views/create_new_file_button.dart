import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 新規ファイル作成ボタンウィジェット。
///
/// 新規ファイルを作成するためのボタンを表示する。
/// スタイリングやアイコンはデザインに準拠する。
class CreateNewFileButton extends StatelessWidget {
  /// ボタンが押されたときに呼び出されるコールバック。
  final VoidCallback? onPressed;

  /// 横方向のパディング。
  final double horizontalPadding;

  /// コンストラクタ。
  const CreateNewFileButton({
    super.key,
    required this.onPressed,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        'assets/icons/plus_icon.svg',
        width: 20,
        height: 20,
        colorFilter: const ColorFilter.mode(
          Color(0xFF9B6ADF),
          BlendMode.srcIn,
        ),
      ),
      label: const Text(
        '新規作成',
        style: TextStyle(
          color: Color(0xFF9B6ADF),
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Noto Sans JP',
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 4,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding * 1.5,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadowColor: const Color(0xFFECECEC),
      ),
    );
  }
}
