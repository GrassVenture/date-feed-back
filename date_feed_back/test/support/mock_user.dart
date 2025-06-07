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