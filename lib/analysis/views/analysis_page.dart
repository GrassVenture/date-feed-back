import 'package:flutter/material.dart';

/// 詳細分析ページ。
///
/// アップロード済み音声ファイルの詳細情報や分析結果を表示するページ。
class AnalysisPage extends StatelessWidget {
  static const routeName = 'detail';
  static const routePath = '/detail/:id';

  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('詳細ページ')),
      body: const Center(child: Text('詳細ページ')),
    );
  }
} 