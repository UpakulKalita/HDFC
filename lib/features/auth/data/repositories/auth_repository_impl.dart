import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insurance_flutter/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl;
  final http.Client client;

  // You can inject a real client for testing, or use the default
  AuthRepositoryImpl({
    this.baseUrl = 'https://7d5d8e2f678e.ngrok-free.app/api', // Real BFF URL
    http.Client? client,
  }) : client = client ?? http.Client();

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String recaptchaToken,
  }) async {
    final url = Uri.parse('$baseUrl/auth/login');
    
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': email,
          'password': password,
        }),
      );

      final body = jsonDecode(response.body);


      // 1. Success (200 OK)
      if (response.statusCode == 200) {
        if (body['status'] == 'SUCCESS') {
          return body as Map<String, dynamic>;
        } else {
          // BFF returns 200 but logic failed
          throw AuthException('Login Failed');
        }
      } 
      
      // 2. Unauthorized (401) / Forbidden (403) / Client Error (400)
      else if (response.statusCode >= 400 && response.statusCode < 500) {
        // Extract error message from BFF response if available
        final message = body['message'] ?? 'Login failed';
        
        if (response.statusCode == 403 && body['code'] == 'ACCOUNT_LOCKED') {
           throw AuthLockoutException(message);
        }
        
        throw AuthException(message);
      } 
      
      // 3. Server Error (500+)
      else {
        throw AuthException('Server error. Please try again later.');
      }
      
    } catch (e) {
      if (e is AuthException || e is AuthLockoutException) {
        rethrow;
      }
      // Handle network errors (offline, timeout)
      throw AuthException('Network error: Is the server running?');
    }
  }
}

// Custom Exceptions
class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}

class AuthLockoutException implements Exception {
  final String message;
  AuthLockoutException(this.message);
  @override
  String toString() => message;
}
