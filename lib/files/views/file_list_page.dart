import 'package:date_feed_back/files/views/widgets/files_responsive_layout_helper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import '../../core/app_color.dart';
import '../../upload/controllers/upload_controller.dart';
import 'sidebar.dart';
import '../../upload/models/date_session.dart';
import 'widgets/file_list_header.dart';
import 'widgets/responsive_file_grid.dart';
import 'widgets/file_upload_dialog.dart';

/// ファイル一覧画面を表示するウィジェット。
///
/// Figmaデザインに基づき、SVGアイコンや配色・レイアウトを反映する。
class FileListPage extends HookConsumerWidget {
  const FileListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(uploadControllerProvider);
    // ダミーファイルリスト
    final files = List.generate(
      7,
      (index) => DateSession(
        title: 'ファイル名',
        createdAt: DateTime(2025, 5, 15),
        time: '12:50',
        user: '佐藤さん',
      ),
    );

    void handleCreateNewFile() async {
      final uploadInput = html.FileUploadInputElement();
      uploadInput.accept = '.mp3,.wav';
      uploadInput.click();
      uploadInput.onChange.listen((event) async {
        final files = uploadInput.files;
        if (files != null && files.isNotEmpty) {
          await ref
              .read(uploadControllerProvider.notifier)
              .handleDroppedFile(files.first);
          // アップロード完了後にリストを更新（ここではsetState相当の再ビルドのみ）
          // 実際のリスト更新はリポジトリ連携時に実装
        }
      });
    }

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          Row(
            children: [
              // サイドバー
              const Sidebar(),
              // メインコンテンツ
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: FileListHeader(
                        onCreateNewFile: handleCreateNewFile,
                        horizontalPadding: FilesResponsiveLayoutHelper.of(
                          context,
                        ).horizontalPadding,
                        userName: 'UserName',
                      ),
                    ),
                    const SizedBox(height: 32),
                    // ファイルカード一覧
                    Expanded(
                      child: ResponsiveFileGrid(
                        files: files,
                        isUploading: uploadState.isUploading,
                        progress: uploadState.progress,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 右下にアップロードダイアログを重ねて表示
          if (uploadState.isUploading)
            Positioned(
              right: 32,
              bottom: 32,
              child: FileUploadDialog(
                fileName: uploadState.fileName ?? 'アップロード中のファイル',
                progress: uploadState.progress,
                onClose: () {
                  ref.read(uploadControllerProvider.notifier).reset();
                },
              ),
            ),
        ],
      ),
    );
  }
}
