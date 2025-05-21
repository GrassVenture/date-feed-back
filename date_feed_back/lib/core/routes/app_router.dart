import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/views/login_page.dart';
import '../../upload/views/upload_page.dart';
import '../../auth/providers/auth_provider.dart';
import '../../analysis/views/analysis_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
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
          final id = state.pathParameters['id'];
          return const AnalysisPage();
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('エラー: ${state.error}'),
      ),
    ),
  );
}); 