import 'package:insurance_flutter/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
    String? captchaToken,
  });

  Future<void> logout();
}
