import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../controllers/upload_controller.dart';

class UploadPage extends HookConsumerWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDragging = useState(false);
    final uploadState = ref.watch(uploadControllerProvider);

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
            DragTarget<Object>(
              onWillAcceptWithDetails: (data) {
                isDragging.value = true;
                return true;
              },
              onAcceptWithDetails: (data) {
                isDragging.value = false;
                // TODO: ドロップされたファイルの処理
              },
              onLeave: (data) {
                isDragging.value = false;
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDragging.value ? Colors.blue : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          size: 48,
                          color: isDragging.value ? Colors.blue : Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isDragging.value
                              ? 'ファイルをドロップしてください'
                              : 'ファイルをドラッグ&ドロップ\nまたは',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDragging.value ? Colors.blue : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: ファイル選択処理の実装
                          },
                          child: const Text('ファイルを選択'),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
