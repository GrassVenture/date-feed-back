import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mock_user.freezed.dart';

/// テスト・開発用のモックユーザーモデル。
///
/// Firebase Auth の [User] の代替として利用する。
@freezed
class MockUser with _$MockUser {
  /// モックユーザーを生成する。
  const factory MockUser({
    required String uid,
    String? email,
    String? displayName,
  }) = _MockUser;
}

/// User を implements したアダプター。
///
/// [MockUser] を [User] 型として扱うためのラッパークラス。
class MockUserAdapter implements User {
  final MockUser mock;

  /// [mock] には freezed の [MockUser] を指定する。
  MockUserAdapter(this.mock);

  @override
  String get uid => mock.uid;
  @override
  String? get email => mock.email;
  @override
  String? get displayName => mock.displayName;

  // User の他のメソッド・プロパティは必要に応じて追加
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

/// モックユーザーを生成する。
///
/// [email] を指定して [MockUserAdapter] を返す。
User createMockUser(String email) {
  return MockUserAdapter(
    MockUser(
      uid: 'mock-uid-${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: 'テストユーザー',
    ),
  );
} 