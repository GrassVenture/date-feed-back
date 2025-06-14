import 'package:flutter/material.dart';

/// レスポンシブレイアウトの設定値を保持するデータクラス。
class ResponsiveLayoutConfig {
  /// グリッドのカラム数。
  final int crossAxisCount;

  /// 水平方向のパディング。
  final double horizontalPadding;

  /// [ResponsiveLayoutConfig] のインスタンスを生成する。
  const ResponsiveLayoutConfig({
    required this.crossAxisCount,
    required this.horizontalPadding,
  });
}

/// 画面幅に応じたレスポンシブレイアウト設定を提供するヘルパークラス。
///
/// 既定のブレークポイント:
/// - 1200px以上: 3カラム, パディング32
/// - 800px以上: 2カラム, パディング24
/// - それ以下: 1カラム, パディング8
class ResponsiveLayoutHelper {
  /// 画面幅から [ResponsiveLayoutConfig] を取得する。
  static ResponsiveLayoutConfig fromWidth(double width) {
    if (width >= 1200) {
      return const ResponsiveLayoutConfig(
          crossAxisCount: 3, horizontalPadding: 32.0);
    } else if (width >= 800) {
      return const ResponsiveLayoutConfig(
          crossAxisCount: 2, horizontalPadding: 24.0);
    } else {
      return const ResponsiveLayoutConfig(
          crossAxisCount: 1, horizontalPadding: 8.0);
    }
  }

  /// [BuildContext] から [ResponsiveLayoutConfig] を取得する。
  static ResponsiveLayoutConfig of(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return fromWidth(width);
  }
}
