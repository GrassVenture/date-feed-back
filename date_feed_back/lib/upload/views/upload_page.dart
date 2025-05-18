import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../controllers/upload_controller.dart';

class UploadPage extends HookConsumerWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(uploadControllerProvider);

    // ここで副作用として遷移処理
    useEffect(() {
      if (!uploadState.isUploading && uploadState.progress >= 1.0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (ModalRoute.of(context)?.isCurrent ?? true) {
            context.go('/detail/dummyId');
          }
        });
      }
      return null;
    }, [uploadState.isUploading, uploadState.progress]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('音声アップロード'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '音声ファイルをアップロード',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
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
                    // アップロード完了後に遷移
                    if (context.mounted) {
                      context.go('/detail/dummyId');
                    }
                  }
                });
              },
              child: const Text('ファイルを選択'),
            ),
            const SizedBox(height: 24),
            if (uploadState.isUploading)
              Column(
                children: [
                  LinearProgressIndicator(
                    value:
                        uploadState.progress > 0 ? uploadState.progress : null,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    uploadState.progress > 0
                        ? 'アップロード中... ${(uploadState.progress * 100).toStringAsFixed(0)}%'
                        : 'アップロード準備中...',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
