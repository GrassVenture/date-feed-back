import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'core/app_color.dart';
import 'files/views/file_list_page.dart';
import 'firebase_options.dart' as prod;
import 'firebase_options_dev.dart' as dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dotenv 初期化
  await dotenv.load();

  final firebaseOptions = kReleaseMode
      ? prod.DefaultFirebaseOptions.currentPlatform
      : dev.DefaultFirebaseOptions.currentPlatform;

  // Firebase 初期化（本番/開発切替）
  await Firebase.initializeApp(options: firebaseOptions);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DateFeedBack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.main,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const FileListPage(),
    );
  }
}
