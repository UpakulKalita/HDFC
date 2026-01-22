import 'dart:math';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  // Text controllers used in UI
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // State
  int _attemptsLeft = 3;
  bool _isLocked = false;
  DateTime? _lockoutEndTime;
  String? _errorMessage;
  bool _isPasswordVisible = false;

  // Getters
  int get attemptsLeft => _attemptsLeft;
  bool get isLocked => _isLocked;
  DateTime? get lockoutEndTime => _lockoutEndTime;
  String? get errorMessage => _errorMessage;
  bool get isPasswordVisible => _isPasswordVisible;

  // Mock Credentials
  final String _validEmail = "admin@hdfc.com";
  final String _validPassword = "admin";

  AuthController() {
    usernameController.addListener(notifyListeners);
    passwordController.addListener(notifyListeners);
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // Basic email validation regex
  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Validation Error Getters
  String? get emailInputError {
    final text = usernameController.text.trim();
    if (text.isEmpty) return null; // No error if empty (yet)
    if (!_emailRegex.hasMatch(text)) {
      return "Invalid email format";
    }
    return null;
  }

  /// Validate username & password
  bool validateFields() {
    return _emailRegex.hasMatch(usernameController.text.trim()) &&
        passwordController.text.isNotEmpty;
  }

  /// Handle Login Logic
  Future<bool> handleLogin(String? captchaToken) async {
    // 1. Check Lockout
    if (_isLocked) {
      if (_lockoutEndTime != null && DateTime.now().isAfter(_lockoutEndTime!)) {
        _resetLockout();
      } else {
         return false; // Still locked
      }
    }

    // 2. Validate Captcha (Mock verification for now)
    if (captchaToken == null) {
      _errorMessage = "Captcha verification failed.";
      notifyListeners();
      return false;
    }

    // 3. Validate Credentials
    final email = usernameController.text.trim();
    final password = passwordController.text; // Don't trim password

    // Mock Check
    // 1. Check if email exists
    if (email.toLowerCase() != _validEmail.toLowerCase()) {
      // Email does not exist
      _errorMessage = "Invalid email or password.";
      notifyListeners();
      return false;
    }

    // 2. Check Password
    if (password != _validPassword) {
      // Valid email, wrong password -> Decrement attempts
      _onLoginFailure();
      return false;
    }

    // 3. Success
    _onLoginSuccess();
    return true;
  }

  void _onLoginSuccess() {
    _attemptsLeft = 3;
    _errorMessage = null;
    // Clear sensitive data
    passwordController.clear(); 
    notifyListeners();
  }

  void _onLoginFailure() {
    _attemptsLeft--;
    if (_attemptsLeft <= 0) {
      _startLockout();
    } else {
      // Show attempts left
      _errorMessage = "Invalid password. $_attemptsLeft ${_attemptsLeft == 1 ? 'attempt' : 'attempts'} left.";
    }
    
    // Clear password on failure as typical security practice? 
    notifyListeners();
  }

  void _startLockout() {
    _isLocked = true;
    _lockoutEndTime = DateTime.now().add(const Duration(minutes: 5));
    _errorMessage = "Account locked due to too many failed attempts. Try again in 5 minutes.";
    notifyListeners();
    
    // Auto-unlock timer
    Future.delayed(const Duration(minutes: 5), () {
      if (_isLocked) {
        _resetLockout();
      }
    });
  }

  void _resetLockout() {
    _isLocked = false;
    _attemptsLeft = 3;
    _lockoutEndTime = null;
    _errorMessage = null;
    notifyListeners();
  }
  
  /// Called when user edits input to clear errors
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
