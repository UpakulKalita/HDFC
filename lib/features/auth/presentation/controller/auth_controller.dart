import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:insurance_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:insurance_flutter/features/auth/data/repositories/auth_repository_impl.dart';

class AuthController extends ChangeNotifier {
  // Dependencies
  final AuthRepository _authRepository;

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

  // final String _validEmail = "admin@hdfc.com";
  // final String _validPassword = "admin";

  AuthController({AuthRepository? repository}) 
      : _authRepository = repository ?? AuthRepositoryImpl() { 
    usernameController.addListener(notifyListeners);
    passwordController.addListener(notifyListeners);
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    _attemptsLeft = prefs.getInt('auth_attempts_left') ?? 3;
    final lockoutTimeStr = prefs.getString('auth_lockout_end_time');

    if (lockoutTimeStr != null) {
      final endTime = DateTime.parse(lockoutTimeStr);
      if (DateTime.now().isBefore(endTime)) {
        _isLocked = true;
        _lockoutEndTime = endTime;
        _errorMessage = "Account locked due to too many failed attempts. Try again in 5 minutes.";
        
        // Resume timer
        final remaining = endTime.difference(DateTime.now());
        Future.delayed(remaining, () {
          if (_isLocked) {
            _resetLockout();
          }
        });
      } else {
        // Time passed while app was closed
        _resetLockout(); 
      }
    }
    notifyListeners();
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

    // 3. Validate Credentials via Repository
    final email = usernameController.text.trim();
    final password = passwordController.text;

    try {
      // Call the API (BFF)
      await _authRepository.login(
        email: email,
        password: password,
        recaptchaToken: captchaToken,
      );
      
      // If no exception, login was successful
      await _onLoginSuccess();
      return true;
      
    } catch (e) {
      // Handle known errors
      if (e is AuthLockoutException) {
         await _startLockout(overrideMessage: e.toString());
         return false;
      }
      
      if (e is AuthException) {
        _errorMessage = e.toString();
        // Only decrement attempts if it's a "Wrong Password" type error?
        // For simplicity, let's say the BFF determines if attempts should be burnt.
        // But for now, let's keep the existing "decrement on failure" behavior 
        // IF the error implies bad creds (usually 401).
        await _onLoginFailure(); 
        return false;
      }

      // Handle unexpected errors
      _errorMessage = "An unexpected error occurred: ${e.toString()}";
      return false;
    }
  }

  Future<void> _onLoginSuccess() async {
    _attemptsLeft = 3;
    _errorMessage = null;
    passwordController.clear();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_attempts_left');
    await prefs.remove('auth_lockout_end_time');
    
    notifyListeners();
  }

  Future<void> _onLoginFailure() async {
    _attemptsLeft--;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('auth_attempts_left', _attemptsLeft);

    if (_attemptsLeft <= 0) {
      _startLockout();
    } else {
      _errorMessage = "Invalid password. $_attemptsLeft ${_attemptsLeft == 1 ? 'attempt' : 'attempts'} left.";
    }
    
    notifyListeners();
  }

  Future<void> _startLockout({String? overrideMessage}) async {
    _isLocked = true;
    _lockoutEndTime = DateTime.now().add(const Duration(minutes: 5));
    _errorMessage = overrideMessage ?? "Account locked due to too many failed attempts. Try again in 5 minutes.";
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_lockout_end_time', _lockoutEndTime!.toIso8601String());
    
    notifyListeners();
    
    // Auto-unlock timer
    Future.delayed(const Duration(minutes: 5), () {
      if (_isLocked) {
        _resetLockout();
      }
    });
  }

  Future<void> _resetLockout() async {
    _isLocked = false;
    _attemptsLeft = 3;
    _lockoutEndTime = null;
    _errorMessage = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_attempts_left');
    await prefs.remove('auth_lockout_end_time');

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
