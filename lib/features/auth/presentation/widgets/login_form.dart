import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart'; // Ensure this points to your new AppColors file
import 'package:insurance_flutter/features/auth/presentation/widgets/recaptcha_widget.dart';
import 'package:insurance_flutter/features/auth/data/services/auth_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  final _recaptchaController = RecaptchaController(); 
  final _authService = AuthService(); 
  bool _captchaError = false;
  bool _isLoading = false; 

  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);

    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      try {
        final token = await _recaptchaController.execute();
        
        if (token != null) {
          debugPrint('reCAPTCHA Success: Token received: ${token.substring(0, 10)}...');
          
          // Call Backend
          try {
            await _authService.login(
              _usernameController.text,
              _passwordController.text,
            );
            
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Successful! Redirecting...'),
                  backgroundColor: AppColors.success, // Updated to Theme Success
                ),
              );
              // Navigation logic would go here
            }
          } catch (e) {
            debugPrint('API Login Error: $e');
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString().replaceAll('Exception: ', '')),
                  backgroundColor: AppColors.error, // Updated to Theme Error
                ),
              );
            }
          }
        } else {
          debugPrint('reCAPTCHA Failed: Token is null');
          setState(() => _captchaError = true);
        }
      } catch (e) {
        debugPrint('reCAPTCHA Error: $e');
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
            color: AppColors.navyBlue, // Updated to Brand Navy
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
                style: GoogleFonts.inter(color: AppColors.error, fontSize: 12),
              ),
            ),
          ),

        const SizedBox(height: 20),

        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleSubmit, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, 
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.zero,
            ),
            child: Ink(
              decoration: BoxDecoration(
                // Logic updated to use AppColors.primaryGradient directly
                gradient: _isLoading 
                    ? const LinearGradient(colors: [AppColors.textLight, AppColors.textGrey]) 
                    : AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.4), // Updated Shadow
                    offset: const Offset(0, 10),
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
              color: AppColors.primaryBlue, // Updated to Primary Blue
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
            color: AppColors.textDark, // Updated to Dark Text
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
                style: const TextStyle(color: AppColors.textDark), // Ensure input text is dark
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(color: AppColors.textLight), // Updated Hint color
                  filled: true,
                  fillColor: AppColors.surface, // Use Surface white
                  contentPadding: const EdgeInsets.only(left: 44, right: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.border, width: 2), // Updated Border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.border, width: 2), // Updated Border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2), // Updated Focus Color
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 14,
              child: Icon(icon, color: AppColors.textLight, size: 20), // Updated Icon Color
            ),
          ],
        ),
      ],
    );
  }
}
