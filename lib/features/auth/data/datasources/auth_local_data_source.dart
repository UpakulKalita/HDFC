import 'package:insurance_flutter/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
    String? captchaToken,
  });

  Future<void> logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // Mock Credentials (copied from AuthController)
  final String _validEmail = "admin@hdfc.com";
  final String _validPassword = "admin";

  @override
  Future<UserModel> login({
    required String email,
    required String password,
    String? captchaToken,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    if (email.toLowerCase() == _validEmail.toLowerCase() && password == _validPassword) {
      if (captchaToken == null) {
        throw Exception("Captcha verification failed.");
      }
      
      return const UserModel(
        id: '1',
        email: 'admin@hdfc.com',
        name: 'HDFC Admin',
      );
    } else {
      throw Exception("Invalid email or password.");
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 50));
  }

}
