import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/views/login_page.dart';
import '../../auth/controllers/auth_notifier.dart';
import '../../analysis/views/analysis_page.dart';
import '../../files/views/file_list_page.dart';

/// アプリ全体のルーティングを提供する [Provider]。
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    /// ルーティング初期パス。
    initialLocation: LoginPage.routePath,

    /// ログイン状態に応じたリダイレクト処理。
    redirect: (context, state) {
      final isLoggedIn = authState.user != null;
      final isGoingToLogin = state.uri.path == LoginPage.routePath;

      // ログイン済みで、ログインページに行こうとしている場合
      if (isLoggedIn && isGoingToLogin) {
        return FileListPage.routePath;
      }

      // 未ログインで、ログインページ以外に行こうとしている場合
      if (!isLoggedIn && !isGoingToLogin) {
        return LoginPage.routePath;
      }

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
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('エラー: ${state.error}'),
      ),
    ),
  );
});
