/// `int` 型を拡張し、時間関連のフォーマット機能を提供する拡張。
extension DurationFormatter on int {
  /// 秒数を `MM:SS` 形式の文字列に変換する。
  ///
  /// ```dart
  /// final seconds = 70;
  /// print(seconds.toMMSS()); // 01:10
  /// ```
  String toMMSS() {
    final minutes = (this ~/ 60).toString().padLeft(2, '0');
    final seconds = (this % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
