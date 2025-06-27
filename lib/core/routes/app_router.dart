import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/views/login_page.dart';
// import '../../auth/controllers/auth_notifier.dart';
import '../../analysis/views/analysis_page.dart';
import '../../files/views/file_list_page.dart';

/// アプリ全体のルーティングを提供する [Provider]。
final appRouterProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    /// ルーティング初期パス。
    initialLocation: FileListPage.routePath,

    /// リダイレクト処理（開発用に無効化）。
    redirect: (context, state) {
      return null;
    },

    /// ルート定義一覧。
    routes: [
      GoRoute(
        path: LoginPage.routePath,
        name: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AnalysisPage.routePath,
        name: AnalysisPage.routeName,
        builder: (context, state) {
          return const AnalysisPage();
        },
      ),
      GoRoute(
        path: FileListPage.routePath,
        name: FileListPage.routeName,
        builder: (context, state) => const FileListPage(),
      ),
    ],

    /// ルーティングエラー時の画面。
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('エラー: ${state.error}'))),
  );
});
