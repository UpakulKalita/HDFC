import 'dart:math';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  // Text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();

  // Captcha state
  String captchaText = "";
  bool captchaError = false;

  AuthController() {
    refreshCaptcha();
  }

  /// Generate new captcha
  void refreshCaptcha() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    captchaText =
        List.generate(6, (i) => chars[Random().nextInt(chars.length)]).join();

    captchaController.clear();
    captchaError = false;
    notifyListeners();
  }

  /// Validate captcha input
  bool validateCaptcha() {
    if (captchaController.text.trim() != captchaText) {
      captchaError = true;
      notifyListeners();
      return false;
    }

    captchaError = false;
    notifyListeners();
    return true;
  }

  /// Validate username & password
  bool validateFields() {
    return usernameController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty;
  }

  /// Clear all fields (optional utility)
  void clearAll() {
    usernameController.clear();
    passwordController.clear();
    captchaController.clear();
    captchaError = false;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    captchaController.dispose();
    super.dispose();
  }
}
