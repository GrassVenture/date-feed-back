import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../support/mock_user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Firebase 認証関連の処理を提供するリポジトリ。
class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  /// [firebaseAuth] を指定しなければデフォルトインスタンスを利用する。
  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// メールアドレスとパスワードでサインインする。
  ///
  /// 成功時は [User] を返す。
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  /// メールアドレスとパスワードで新規登録する。
  ///
  /// デバッグ時はモックユーザーを返す。
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        return createMockUser(email);
      }
      rethrow;
    }
  }

  /// Google アカウントでサインインする。
  ///
  /// 成功時は [User] を返す。
  Future<User?> signInWithGoogle() async {
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();
    final userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
    return userCredential.user;
  }

  /// サインアウトする。
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

/// [AuthRepository] のプロバイダー。
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
}); 