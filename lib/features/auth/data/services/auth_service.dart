import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final Dio _dio = Dio();
  // Using the ngrok URL provided by the user
  final String _baseUrl = 'https://oversmoothly-graptolitic-lyn.ngrok-free.dev';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/api/auth/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // Add any other headers if needed, e.g. ngrok-skip-browser-warning for ngrok free tier sometimes
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data is Map<String, dynamic> ? response.data : {'data': response.data};
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      debugPrint('Login API Error: ${e.message}');
      if (e.response != null) {
        debugPrint('Error Response: ${e.response?.data}');
        // Try to extract a meaningful error message from the backend
        final errorData = e.response?.data;
        String errorMessage = 'Login failed';
        if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        }
        throw Exception(errorMessage);
      }
      throw Exception('Connection error. Please check your internet connection.');
    } catch (e) {
      debugPrint('Unexpected Login Error: $e');
      rethrow;
    }
  }
}
