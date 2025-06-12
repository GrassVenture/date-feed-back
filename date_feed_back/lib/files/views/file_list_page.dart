import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import '../../upload/controllers/upload_controller.dart';
import '../../upload/views/upload_uploading_file_card.dart';
import 'sidebar.dart';
import 'create_new_file_button.dart';

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
      (index) => {
        'title': 'ファイル名',
        'date': '2025/05/15',
        'time': '12:50',
        'user': '佐藤さん',
      },
    );
    return Scaffold(
      backgroundColor: const Color(0xFFFBFAFE),
      body: Row(
        children: [
          // サイドバー
          const Sidebar(),
          // メインコンテンツ
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 画面幅に応じてカラム数とパディングを決定
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
                  child: Column(
                    children: [
                      // ヘッダー
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CreateNewFileButton(
                            onPressed: () async {
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
                            },
                            horizontalPadding: horizontalPadding,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFD9D9D9),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/person_icon2.svg',
                                    width: 14,
                                    height: 14,
                                    colorFilter: const ColorFilter.mode(
                                        Color(0xFF645E6D), BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'UserName',
                                style: TextStyle(
                                  color: Color(0xFF2F2F2F),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  fontFamily: 'Noto Sans JP',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      if (uploadState.isUploading)
                        Column(
                          children: [
                            const LinearProgressIndicator(),
                            const SizedBox(height: 8),
                            Text(
                              uploadState.progress > 0
                                  ? 'アップロード中... ${(uploadState.progress * 100).toStringAsFixed(0)}%'
                                  : 'アップロード準備中...',
                            ),
                          ],
                        ),
                      // ファイルカード一覧
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32,
                            childAspectRatio: 2.2,
                          ),
                          itemCount: uploadState.isUploading
                              ? files.length + 1
                              : files.length,
                          itemBuilder: (context, index) {
                            if (uploadState.isUploading && index == 0) {
                              return UploadUploadingFileCard(
                                fileName:
                                    uploadState.fileName ?? 'アップロード中のファイル',
                                progress: uploadState.progress,
                                fileSize: uploadState.fileSize,
                                onCancel: () {
                                  // キャンセル処理: 状態リセット
                                  ref
                                      .read(uploadControllerProvider.notifier)
                                      .reset();
                                },
                              );
                            }
                            final file = files[
                                uploadState.isUploading ? index - 1 : index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFFECECEC),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 4),
                                      Text(
                                        file['title']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Noto Sans JP',
                                          color: Color(0xFF645E6D),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Text(
                                        '作成日:',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF645E6D),
                                          fontFamily: 'Noto Sans JP',
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        file['date']!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF645E6D),
                                          fontFamily: 'Noto Sans JP',
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      SvgPicture.asset(
                                        'assets/icons/play_circle_outline.svg',
                                        width: 16,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(
                                            Color(0xFF645E6D), BlendMode.srcIn),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        file['time']!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF645E6D),
                                          fontFamily: 'Noto Sans JP',
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      SvgPicture.asset(
                                        'assets/icons/person2.svg',
                                        width: 16,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(
                                            Color(0xFF645E6D), BlendMode.srcIn),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        file['user']!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF645E6D),
                                          fontFamily: 'Noto Sans JP',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
