import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/utils/captcha.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _captchaInputController = TextEditingController();
  
  String _captchaText = CaptchaUtils.generateCaptcha();
  bool _captchaError = false;

  void _refreshCaptcha() {
    setState(() {
      _captchaText = CaptchaUtils.generateCaptcha();
      _captchaInputController.clear();
      _captchaError = false;
    });
  }

  void _handleSubmit() {
    if (_captchaInputController.text != _captchaText) {
      setState(() {
        _captchaError = true;
      });
      return;
    }

    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful!')),
      );
      // Navigate to dashboard page
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _captchaInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Log In',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Enter your credentials to access the portal',
          style: GoogleFonts.inter(
            color: AppColors.textGrey,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 24),

        // Username
        _InputField(
          label: 'Username',
          icon: LucideIcons.user,
          controller: _usernameController,
          hint: 'Enter your username',
        ),
        const SizedBox(height: 16),

        // Password
        _InputField(
          label: 'Password',
          icon: LucideIcons.lock,
          controller: _passwordController,
          hint: 'Enter your password',
          isPassword: true,
        ),
        const SizedBox(height: 16),

        // Captcha
        Text(
          'Captcha',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _captchaText,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                  decoration: TextDecoration.lineThrough,
                  letterSpacing: 6,
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: _refreshCaptcha,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(LucideIcons.refreshCw, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: TextField(
            controller: _captchaInputController,
            onChanged: (_) => setState(() => _captchaError = false),
            decoration: InputDecoration(
              hintText: 'Enter the captcha shown above',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _captchaError ? Colors.red.shade500 : Colors.grey.shade200,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _captchaError ? Colors.red.shade500 : Colors.grey.shade200,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
          ),
        ),
        if (_captchaError)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              'Incorrect captcha. Please try again.',
              style: GoogleFonts.inter(color: Colors.red.shade500, fontSize: 12),
            ),
          ),

        const SizedBox(height: 20),

        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, 
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.zero,
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.gradientStart, AppColors.gradientEnd],
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 76, 143, 0.5),
                    offset: Offset(0, 10),
                    blurRadius: 25,
                    spreadRadius: -5,
                  )
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Log In',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),
        Center(
          child: Text(
            'Forgot your password?',
            style: GoogleFonts.inter(
              color: AppColors.primary,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String hint;
  final bool isPassword;

  const _InputField({
    required this.label,
    required this.icon,
    required this.controller,
    required this.hint,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            SizedBox(
              height: 48,
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(left: 44, right: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 14,
              child: Icon(icon, color: Colors.grey.shade400, size: 20),
            ),
          ],
        ),
      ],
    );
  }
}
