import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    return const AuthState();
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