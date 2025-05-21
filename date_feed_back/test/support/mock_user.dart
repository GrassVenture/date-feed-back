import 'package:firebase_auth/firebase_auth.dart';

/// テスト・開発用のモックUserクラス
class MockUser implements User {
  @override
  final String uid;
  @override
  final String? email;
  @override
  final String? displayName;

  MockUser({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
} 