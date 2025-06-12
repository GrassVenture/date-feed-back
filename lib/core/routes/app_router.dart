import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/views/login_page.dart';
import '../../upload/views/upload_page.dart';
import '../../auth/controllers/auth_notifier.dart';
import '../../analysis/views/analysis_page.dart';

/// アプリ全体のルーティングを提供する [Provider]。
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    /// ルーティング初期パス。
    initialLocation: '/login',

    /// ログイン状態に応じたリダイレクト処理。
    redirect: (context, state) {
      final isLoggedIn = authState.user != null;
      final isGoingToLogin = state.uri.path == '/login';

      // ログイン済みで、ログインページに行こうとしている場合
      if (isLoggedIn && isGoingToLogin) {
        return '/upload';
      }

      // 未ログインで、ログインページ以外に行こうとしている場合
      if (!isLoggedIn && !isGoingToLogin) {
        return '/login';
      }

      return null;
    },

    /// ルート定義一覧。
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/upload',
        name: 'upload',
        builder: (context, state) => const UploadPage(),
      ),
      GoRoute(
        path: '/detail/:id',
        name: 'detail',
        builder: (context, state) {
          return const AnalysisPage();
        },
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
