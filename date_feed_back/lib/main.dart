import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;

import 'firebase_options.dart' as prod;
import 'firebase_options_dev.dart' as dev;
import 'upload/views/upload_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseOptions = kReleaseMode
      ? prod.DefaultFirebaseOptions.currentPlatform
      : dev.DefaultFirebaseOptions.currentPlatform;
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UploadPage(),
    );
  }
}
