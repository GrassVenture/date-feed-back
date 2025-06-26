
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'core/app_color.dart';
import 'core/routes/app_router.dart';
import 'firebase_options.dart' as prod;
import 'firebase_options_dev.dart' as dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseOptions = kReleaseMode
      ? prod.DefaultFirebaseOptions.currentPlatform
      : dev.DefaultFirebaseOptions.currentPlatform;

  // Firebase 初期化（本番/開発切替）
  await Firebase.initializeApp(options: firebaseOptions);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'DateFeedBack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.main,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
    );
  }
}
