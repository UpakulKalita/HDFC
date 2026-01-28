import 'dart:async';
import 'package:flutter/material.dart';
import 'package:insurance_flutter/features/auth/domain/entities/user.dart';
import 'package:insurance_flutter/features/auth/domain/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  // Text controllers used in UI (Moved from AuthController)
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // State
  User? _user;
  bool _isLoading = false;
  int _attemptsLeft = 3;
  bool _isLocked = false;
  DateTime? _lockoutEndTime;
  String? _errorMessage;
  bool _isPasswordVisible = false;

  AuthProvider({required this.repository}) {
    usernameController.addListener(notifyListeners);
    passwordController.addListener(notifyListeners);
  }

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  int get attemptsLeft => _attemptsLeft;
  bool get isLocked => _isLocked;
  DateTime? get lockoutEndTime => _lockoutEndTime;
  String? get errorMessage => _errorMessage;
  bool get isPasswordVisible => _isPasswordVisible;

  // Basic email validation regex
  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Validation Error Getters
  String? get emailInputError {
    final text = usernameController.text.trim();
    if (text.isEmpty) return null;
    if (!_emailRegex.hasMatch(text)) {
      return "Invalid email format";
    }
    return null;
  }

  bool validateFields() {
    return _emailRegex.hasMatch(usernameController.text.trim()) &&
        passwordController.text.isNotEmpty;
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<bool> login(String? captchaToken) async {
    // 1. Check Lockout
    if (_isLocked) {
      if (_lockoutEndTime != null && DateTime.now().isAfter(_lockoutEndTime!)) {
        _resetLockout();
      } else {
        return false;
      }
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final email = usernameController.text.trim();
      final password = passwordController.text;

      _user = await repository.login(
        email: email,
        password: password,
        captchaToken: captchaToken,
      );
      
      _onLoginSuccess();
      return true;
    } catch (e) {
      _onLoginFailure(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _onLoginSuccess() {
    _attemptsLeft = 3;
    _errorMessage = null;
    passwordController.clear();
  }

  void _onLoginFailure(String error) {
    _attemptsLeft--;
    if (_attemptsLeft <= 0) {
      _startLockout();
    } else {
      if (error.contains("Captcha")) {
         _errorMessage = "Captcha verification failed.";
         _attemptsLeft++; // Don't penalize for captcha failure? 
      } else {
        _errorMessage = "Invalid email or password. $_attemptsLeft ${_attemptsLeft == 1 ? 'attempt' : 'attempts'} left.";
      }
    }
  }

  void _startLockout() {
    _isLocked = true;
    _lockoutEndTime = DateTime.now().add(const Duration(minutes: 5));
    _errorMessage = "Account locked due to too many failed attempts. Try again in 5 minutes.";
    
    Timer(const Duration(minutes: 5), () {
      _resetLockout();
    });
  }

  void _resetLockout() {
    _isLocked = false;
    _attemptsLeft = 3;
    _lockoutEndTime = null;
    _errorMessage = null;
    notifyListeners();
  }

  void clearErrors() {
    if (_errorMessage != null && !_isLocked) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
