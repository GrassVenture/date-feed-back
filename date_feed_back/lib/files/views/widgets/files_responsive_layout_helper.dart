import 'package:flutter/material.dart';

import 'files_responsive_layout_config.dart';

/// 画面幅に応じたレスポンシブレイアウト設定を提供するヘルパークラス。
///
/// 既定のブレークポイント:
/// - 1200px以上: 3カラム, パディング32
/// - 800px以上: 2カラム, パディング24
/// - それ以下: 1カラム, パディング8
class FilesResponsiveLayoutHelper {
  /// 画面幅から [FilesResponsiveLayoutConfig] を取得する。
  static FilesResponsiveLayoutConfig fromWidth(double width) {
    if (width >= 1200) {
      return const FilesResponsiveLayoutConfig(
          crossAxisCount: 3, horizontalPadding: 32.0);
    } else if (width >= 800) {
      return const FilesResponsiveLayoutConfig(
          crossAxisCount: 2, horizontalPadding: 24.0);
    } else {
      return const FilesResponsiveLayoutConfig(
          crossAxisCount: 1, horizontalPadding: 8.0);
    }
  }

  /// [BuildContext] から [FilesResponsiveLayoutConfig] を取得する。
  static FilesResponsiveLayoutConfig of(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return fromWidth(width);
  }
}
