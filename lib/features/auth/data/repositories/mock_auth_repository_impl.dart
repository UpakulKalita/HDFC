import 'package:insurance_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:insurance_flutter/features/auth/data/repositories/auth_repository_impl.dart'; // For Exceptions

class MockAuthRepositoryImpl implements AuthRepository {
  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String recaptchaToken,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // 1. Success Case
    if (email == 'test@example.com' && password == 'password123') {
      return {
        'status': 'SUCCESS',
        'token': 'mock_token_12345',
        'user': {
          'id': 'user_001',
          'email': 'test@example.com',
          'name': 'Test User'
        }
      };
    }

    // 2. Account Locked Case
    if (email == 'locked@example.com') {
      throw AuthLockoutException('Account locked due to too many failed attempts.');
    }

    // 3. Failure Case (Invalid Credentials)
    throw AuthException('Invalid email or password');
  }
}
