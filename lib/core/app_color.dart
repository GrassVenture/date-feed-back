import 'package:flutter/material.dart';


/// アプリ全体で使用するカラーパレットを定義するクラス。
///
/// ブランドカラーやグレースケール、エラー色などを一元管理する。
abstract final class AppColor {

  /// メインカラー（スウォッチ）。
  static const MaterialColor main = MaterialColor(
    _mainPrimaryValue,
    <int, Color>{
      50: Color(0xFFFBFAFE), //background
      100: Color(0xFFE0CBFC),//main-light
      200: Color(0xFFF1E6FC), 
      300: Color(_mainPrimaryValue), // main
      400: Color(0xFF9B6ADF),
      500: Color(0xFF9B6ADF),
      600: Color(0xFF3C1A6C), // main-dark
      700: Color(0xFF59308C), 
      800: Color(0xFF43206B), 
      900: Color(0xFF2C104A),
    },
  );
  static const int _mainPrimaryValue = 0xFF9B6ADF;

  /// グレースケール（スウォッチ）。
  static const MaterialColor gray = MaterialColor(
    _grayPrimaryValue,
    <int, Color>{
      50: Color(0xFFF4F4F5), // gray-light
      100: Color(0xFFE3E2E4), // gray-middle
      200: Color(0xFFF0EEF4), 
      300: Color(_grayPrimaryValue), // gray
      400: Color(0xFFB0A7C0), 
      500: Color(0xFF968EA3),
      600: Color(0xFF645E6D), // text-light
      700: Color(0xFF2F2F2F), // text-black
      800: Color(0xFF23202A), 
      900: Color(0xFF18151C), 
    },
  );
  static const int _grayPrimaryValue = 0xFF8B8593;

  /// 背景色。
  static Color get background => main[50]!;

  /// 明るいテキスト色。
  static Color get textLight => gray[600]!;

  /// 黒に近いテキスト色。
  static Color get textBlack => gray[700]!;

  /// 明るいグレー。
  static Color get grayLight => gray[50]!;

  /// 中間のグレー。
  static Color get grayMiddle => gray[100]!;

  /// 明るいメインカラー。
  static Color get mainLight => main[100]!;

  /// 暗いメインカラー。
  static Color get mainDark => main[600]!;

  /// アラート・エラー用の赤色。
  static const Color alert = Color(0xFFE04F4F);
}