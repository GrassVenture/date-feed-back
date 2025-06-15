import 'package:flutter/material.dart';

/// ファイルアップロードの進捗状況を示すウィジェット。
///
/// `progress` の値に基づいて、`CircularProgressIndicator` または完了を示すチェックマークアイコンを表示する。
class ProgressIndicatorWidget extends StatelessWidget {
  /// 進捗状況。0.0〜1.0 の範囲。
  final double progress;

  /// [ProgressIndicatorWidget] のコンストラクタ。
  const ProgressIndicatorWidget({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return progress < 1.0
        ? SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6,
                    backgroundColor: const Color(0xFFECECEC),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFF9B6ADF)),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF9B6ADF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              size: 32,
              color: Colors.white,
            ),
          );
  }
}
