/// レスポンシブレイアウトの設定値を保持するデータクラス。
class FilesResponsiveLayoutConfig {
  /// グリッドのカラム数。
  final int crossAxisCount;

  /// 水平方向のパディング。
  final double horizontalPadding;

  /// [FilesResponsiveLayoutConfig] のインスタンスを生成する。
  const FilesResponsiveLayoutConfig({
    required this.crossAxisCount,
    required this.horizontalPadding,
  });
}
