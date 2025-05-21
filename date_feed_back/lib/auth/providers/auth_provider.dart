import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/auth_state.dart';
import 'package:date_feed_back/support/mock_user.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  // メールとパスワードでログイン
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = state.copyWith(user: userCredential.user, isLoading: false);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'このメールアドレスのユーザーが見つかりません。';
          break;
        case 'wrong-password':
          message = 'パスワードが間違っています。';
          break;
        case 'invalid-email':
          message = 'メールアドレスの形式が正しくありません。';
          break;
        case 'user-disabled':
          message = 'このアカウントは無効になっています。';
          break;
        default:
          message = 'ログインに失敗しました。もう一度お試しください。';
      }
      state = state.copyWith(
        isLoading: false,
        errorMessage: message,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'ログインに失敗しました。もう一度お試しください。',
      );
    }
  }

  // メールとパスワードでユーザー登録
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      try {
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        state = state.copyWith(user: userCredential.user, isLoading: false);
        return;
      } on FirebaseAuthException catch (e) {
        // Firebase認証のエラーだが、開発モードの場合はテスト用ユーザーで登録成功にする
        if (kDebugMode) {
          print('Firebase認証エラー: ${e.code} - ${e.message}');
          // 開発モードでテスト用ユーザーを返す
          final testUser = createMockUser(email);
          state = state.copyWith(user: testUser, isLoading: false);
          return;
        }

        String message;
        switch (e.code) {
          case 'email-already-in-use':
            message = 'このメールアドレスは既に使用されています。';
            break;
          case 'invalid-email':
            message = 'メールアドレスの形式が正しくありません。';
            break;
          case 'weak-password':
            message = 'パスワードが弱すぎます。より強力なパスワードを設定してください。';
            break;
          case 'operation-not-allowed':
            message = 'この操作は許可されていません。';
            break;
          default:
            message = 'アカウント作成に失敗しました。もう一度お試しください。';
        }
        state = state.copyWith(
          isLoading: false,
          errorMessage: message,
        );
      }
    } catch (e) {
      print('予期せぬエラー: $e');
      
      // 開発モードの場合、テスト用ユーザー登録を許可
      if (kDebugMode) {
        final testUser = createMockUser(email);
        state = state.copyWith(user: testUser, isLoading: false);
        return;
      }
      
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'アカウント作成に失敗しました。もう一度お試しください。',
      );
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      state = state.copyWith(user: userCredential.user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Googleログインに失敗しました。もう一度お試しください。',
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await FirebaseAuth.instance.signOut();
      state = state.copyWith(user: null, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'ログアウトに失敗しました。もう一度お試しください。',
      );
    }
  }
} 