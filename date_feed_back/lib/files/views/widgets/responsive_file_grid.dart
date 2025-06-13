import 'package:flutter/material.dart';

import '../../../upload/views/upload_uploading_file_card.dart';
import 'file_card.dart';
import 'file_data.dart';

/// レスポンシブなファイルグリッドを表示するウィジェット。
///
/// ファイルリストやアップロード中カードをグリッドで表示する。
class ResponsiveFileGrid extends StatelessWidget {
  /// ファイルデータのリスト。
  final List<FileData> files;

  /// アップロード中かどうか。
  final bool isUploading;

  /// アップロード中ファイル名。
  final String? uploadingFileName;

  /// アップロード進捗（0.0〜1.0）。
  final double progress;

  /// アップロード中ファイルサイズ。
  final int? fileSize;

  /// アップロードキャンセル時のコールバック。
  final VoidCallback onCancelUpload;

  /// [ResponsiveFileGrid] のインスタンスを生成する。
  const ResponsiveFileGrid({
    super.key,
    required this.files,
    required this.isUploading,
    required this.uploadingFileName,
    required this.progress,
    required this.fileSize,
    required this.onCancelUpload,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double horizontalPadding;
        if (constraints.maxWidth >= 1200) {
          crossAxisCount = 3;
          horizontalPadding = 32.0;
        } else if (constraints.maxWidth >= 800) {
          crossAxisCount = 2;
          horizontalPadding = 24.0;
        } else {
          crossAxisCount = 1;
          horizontalPadding = 8.0;
        }
        return Padding(
          padding: EdgeInsets.all(horizontalPadding),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 32,
              crossAxisSpacing: 32,
              childAspectRatio: 2.2,
            ),
            itemCount: isUploading ? files.length + 1 : files.length,
            itemBuilder: (context, index) {
              if (isUploading && index == 0) {
                return UploadUploadingFileCard(
                  fileName: uploadingFileName ?? 'アップロード中のファイル',
                  progress: progress,
                  fileSize: fileSize,
                  onCancel: onCancelUpload,
                );
              }
              final file = files[isUploading ? index - 1 : index];
              return FileCard(file: file);
            },
          ),
        );
      },
    );
  }
}
