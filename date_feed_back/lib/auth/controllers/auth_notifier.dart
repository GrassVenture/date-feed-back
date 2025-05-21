import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/auth_state.dart';
import '../repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.read(authRepositoryProvider);
    return const AuthState();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _authRepository.signInWithEmailAndPassword(email, password);
      state = state.copyWith(user: user, isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapFirebaseAuthExceptionToMessage(e),
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'ログインに失敗しました。もう一度お試しください。',
      );
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _authRepository.signUpWithEmailAndPassword(email, password);
      state = state.copyWith(user: user, isLoading: false);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapFirebaseAuthExceptionToMessage(e),
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'アカウント作成に失敗しました。もう一度お試しください。',
      );
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _authRepository.signInWithGoogle();
      state = state.copyWith(user: user, isLoading: false);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Googleログインに失敗しました。もう一度お試しください。',
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _authRepository.signOut();
      state = state.copyWith(user: null, isLoading: false);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'ログアウトに失敗しました。もう一度お試しください。',
      );
    }
  }

  String _mapFirebaseAuthExceptionToMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'このメールアドレスのユーザーが見つかりません。';
      case 'wrong-password':
        return 'パスワードが間違っています。';
      case 'invalid-email':
        return 'メールアドレスの形式が正しくありません。';
      case 'user-disabled':
        return 'このアカウントは無効になっています。';
      case 'email-already-in-use':
        return 'このメールアドレスは既に使用されています。';
      case 'weak-password':
        return 'パスワードが弱すぎます。より強力なパスワードを設定してください。';
      case 'operation-not-allowed':
        return 'この操作は許可されていません。';
      default:
        return '認証に失敗しました。もう一度お試しください。';
    }
  }
} 