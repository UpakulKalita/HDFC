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
}
