<<<<<<< HEAD
import 'package:insurance_flutter/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
    String? captchaToken,
  });

  Future<void> logout();
=======
abstract class AuthRepository {
  /// Attempts to log in the user with the given credentials.
  /// 
  /// Returns a Map of user data/tokens if successful.
  /// Throws an Exception if login fails (invalid credentials, locked account, network error).
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String recaptchaToken,
  });
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
}
