import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/recaptcha_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  final _recaptchaController = RecaptchaController(); // New Controller
  bool _captchaError = false;
  bool _isLoading = false; // New loading state


  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);

    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      try {
        final token = await _recaptchaController.execute();
        
        if (token != null) {
          debugPrint('reCAPTCHA Success: Token received: \${token.substring(0, 10)}...');
          // Token received, proceed with login (mock)
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Successful!')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardPage()),
            );
          }
        } else {
          debugPrint('reCAPTCHA Failed: Token is null');
          setState(() => _captchaError = true);
        }
      } catch (e) {
        debugPrint('reCAPTCHA Error: \$e');
        setState(() => _captchaError = true);
      }
    }
    
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
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
          label: 'Email Id',
          icon: LucideIcons.user,
          controller: _usernameController,
          hint: 'Enter your email id',
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

        // reCAPTCHA (Invisible)
        RecaptchaWidget(controller: _recaptchaController),
        
        if (_captchaError)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: Text(
                'Verification failed. Please try again.',
                style: GoogleFonts.inter(color: Colors.red.shade500, fontSize: 12),
              ),
            ),
          ),

        const SizedBox(height: 20),

        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleSubmit, // Disable while loading
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, 
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.zero,
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isLoading 
                    ? [Colors.grey, Colors.grey.shade700] 
                    : [AppColors.gradientStart, AppColors.gradientEnd],
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
                child: _isLoading 
                  ? const SizedBox(
                      width: 24, 
                      height: 24, 
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    )
                  : Text(
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
