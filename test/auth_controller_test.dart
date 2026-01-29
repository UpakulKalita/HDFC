import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:insurance_flutter/features/auth/presentation/controller/auth_controller.dart';
import 'package:insurance_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:insurance_flutter/features/auth/data/repositories/auth_repository_impl.dart';

// 1. Create a Mock Repository
class MockAuthRepository implements AuthRepository {
  bool shouldFail = false;
  bool shouldThrowLockout = false;

  @override
  Future<Map<String, dynamic>> login({required String email, required String password, required String recaptchaToken}) async {
    if (shouldThrowLockout) {
      throw AuthLockoutException("Mock Lockout");
    }
    if (shouldFail) {
      throw AuthException("Mock Invalid Credentials");
    }
    return {"token": "mock_token"};
  }
}

void main() {
  group('AuthController Persistence Tests', () {
    test('Should start with 3 attempts by default', () async {
      SharedPreferences.setMockInitialValues({});
      // Inject Mock
      final mockRepo = MockAuthRepository();
      final auth = AuthController(repository: mockRepo);
      
      // Wait for _loadState()
      await Future.delayed(Duration.zero);
      
      expect(auth.attemptsLeft, 3);
      expect(auth.isLocked, false);
    });

    test('Should decrease attempts and save to SharedPreferences on failure', () async {
      SharedPreferences.setMockInitialValues({});
      
      final mockRepo = MockAuthRepository();
      mockRepo.shouldFail = true; // Force failure at Repo level
      
      final auth = AuthController(repository: mockRepo);
      await Future.delayed(Duration.zero);

      // Use any credentials (mock repo controls outcome)
      auth.usernameController.text = "admin@hdfc.com";
      auth.passwordController.text = "any_password";

      // Trigger login failure
      await auth.handleLogin("mock_token");

      expect(auth.attemptsLeft, 2);

      // Verify it was saved to prefs
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('auth_attempts_left'), 2);
    });

    test('Should load previous attempts from SharedPreferences (Simulating App Restart)', () async {
      // Simulate existing state in storage
      SharedPreferences.setMockInitialValues({
        'auth_attempts_left': 1
      });

      final mockRepo = MockAuthRepository();
      final auth = AuthController(repository: mockRepo); 
      
      // Give time for _loadState to run
      await Future.delayed(const Duration(milliseconds: 50));

      expect(auth.attemptsLeft, 1);
    });

    test('Should persist lockout state', () async {
      SharedPreferences.setMockInitialValues({});
      
      final mockRepo = MockAuthRepository();
      mockRepo.shouldFail = true; // Always fail
      
      final auth = AuthController(repository: mockRepo);
      await Future.delayed(Duration.zero);

      auth.usernameController.text = "admin@hdfc.com";
      auth.passwordController.text = "wrong_password";

      // Fail 3 times to trigger lockout
      await auth.handleLogin("mock_token"); // 2
      await auth.handleLogin("mock_token"); // 1
      await auth.handleLogin("mock_token"); // 0 -> Locked

      expect(auth.isLocked, true);
      
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('auth_lockout_end_time'), isNotNull);
    });

    test('Should remain locked after restart if time has not passed', () async {
      final futureTime = DateTime.now().add(const Duration(minutes: 5));
      
      SharedPreferences.setMockInitialValues({
        'auth_lockout_end_time': futureTime.toIso8601String()
      });

      final mockRepo = MockAuthRepository();
      final auth = AuthController(repository: mockRepo);
      await Future.delayed(const Duration(milliseconds: 50));

      expect(auth.isLocked, true);
      expect(auth.errorMessage, contains("Account locked"));
    });
  });
}
