import 'package:flutter/material.dart';

import '../../../core/app_color.dart';
import '../../../upload/models/date_session.dart';
import 'file_card.dart';
import 'files_responsive_layout_helper.dart';

/// レスポンシブなファイルグリッドを表示するウィジェット。
///
/// ファイルリストやアップロード中カードをグリッドで表示する。
class ResponsiveFileGrid extends StatelessWidget {
  /// ファイルデータのリスト。
  final List<DateSession> files;

  /// アップロード中かどうか。
  final bool isUploading;

  /// アップロード進捗（0.0〜1.0）。
  final double progress;

  /// [ResponsiveFileGrid] のインスタンスを生成する。
  const ResponsiveFileGrid({
    super.key,
    required this.files,
    required this.isUploading,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final config = FilesResponsiveLayoutHelper.fromWidth(
          constraints.maxWidth,
        );
        return Padding(
          padding: EdgeInsets.all(config.horizontalPadding),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: config.crossAxisCount,
              mainAxisSpacing: 32,
              crossAxisSpacing: 32,
              childAspectRatio: 2.2,
            ),
            itemCount: files.length,
            itemBuilder: (context, index) {
              final file = files[index];

              Widget fileCardWidget = FileCard(file: file);

              if (isUploading && index == 0) {
                fileCardWidget = Stack(
                  children: [
                    fileCardWidget,
                    Positioned.fill(
                      child: Container(
                        color: Colors.black54,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColor.main,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return fileCardWidget;
            },
          ),
        );
      },
    );
  }
}
