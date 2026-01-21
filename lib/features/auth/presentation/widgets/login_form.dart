import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/auth/presentation/controller/auth_controller.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/recaptcha_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _recaptchaController = RecaptchaController();
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthController auth) async {
    setState(() => _isLoading = true);

    try {
      // 1. Execute Recaptcha
      final token = await _recaptchaController.execute();
      
      // 2. Handle Login via Controller
      // Pass token even if null, controller handles it
      final success = await auth.handleLogin(token);

      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardPage()),
          );
        }
      }
    } catch (e) {
      debugPrint('Login Error: \$e');
      // Verify if we need to show generic error via controller or local
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, auth, _) {
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
              controller: auth.usernameController,
              hint: 'Enter your email id',
              errorText: auth.errorMessage != null && auth.errorMessage!.contains("email") ? "" : null, // Highlight logic handled in InputField border if needed, or simple error text below.
              // PDF says "Error message shown above Email field in red" for Credential Mismatch?
              // Actually PDF: "Error message shown above Email field in red". "Email and Password fields highlighted in red".
              // Let's passed hasError flag.
              hasError: auth.errorMessage != null,
              onChanged: (_) => auth.clearErrors(),
            ),
            
            // Error Message (Above Email as per 'Credential Mismatch' section point 1? Or generic?)
            // "Error message shown above Email field in red"
            if (auth.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  auth.errorMessage!,
                  style: GoogleFonts.inter(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              
            const SizedBox(height: 16),

            // Password
            _InputField(
              label: 'Password',
              icon: LucideIcons.lock,
              controller: auth.passwordController,
              hint: 'Enter your password',
              isPassword: !auth.isPasswordVisible,
              hasEye: auth.passwordController.text.isNotEmpty,
              onEyeTap: auth.togglePasswordVisibility,
              hasError: auth.errorMessage != null,
              onChanged: (_) {
                auth.clearErrors();
                setState(() {}); // specific to refresh eye icon visibility
              },
            ),
            const SizedBox(height: 16),

            // reCAPTCHA (Invisible)
            RecaptchaWidget(controller: _recaptchaController),
            
            // Lockout Message handled via errorMessage mostly, but if popup needed?
            // "Lockout popup shown with message". 
            // For now, let's keep it defined in error message text or a specific dialogue.
            // Requirement 12: "Lockout popup shown with message".
            // Let's verify if we should show a dialog.
            
            if (auth.isLocked)
               Container(
                 padding: const EdgeInsets.all(12),
                 decoration: BoxDecoration(
                   color: Colors.red.shade50,
                   borderRadius: BorderRadius.circular(8),
                   border: Border.all(color: Colors.red.shade200),
                 ),
                 child: Row(
                   children: [
                     const Icon(LucideIcons.alertCircle, color: Colors.red, size: 20),
                     const SizedBox(width: 8),
                     Expanded(child: Text(auth.errorMessage ?? "Account Locked", style: const TextStyle(color: Colors.red))),
                   ],
                 ),
               ),

            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                // Disabled if locked OR fields empty (Requirement 7)
                onPressed: (_isLoading || auth.isLocked || !auth.validateFields()) 
                    ? null 
                    : () => _handleSubmit(auth),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, 
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.zero,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: (_isLoading || auth.isLocked || !auth.validateFields())
                        ? [Colors.grey, Colors.grey.shade700] 
                        : [AppColors.gradientStart, AppColors.gradientEnd],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      if (!(_isLoading || auth.isLocked || !auth.validateFields()))
                        const BoxShadow(
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
      },
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final bool hasEye;
  final bool hasError;
  final VoidCallback? onEyeTap;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const _InputField({
    required this.label,
    required this.icon,
    required this.controller,
    required this.hint,
    this.isPassword = false,
    this.hasEye = false,
    this.hasError = false,
    this.onEyeTap,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (errorText == null) // If Error text is above logic, we might not need label modification
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
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(left: 44, right: 48), // Right padding for eye
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: hasError ? Colors.red : Colors.grey.shade200, width: hasError ? 2 : 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: hasError ? Colors.red : Colors.grey.shade200, width: hasError ? 2 : 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: hasError ? Colors.red : AppColors.primary, width: 2),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 14,
              child: Icon(icon, color: Colors.grey.shade400, size: 20),
            ),
            if (hasEye)
              Positioned(
                right: 12,
                top: 12,
                child: GestureDetector(
                  onTap: onEyeTap,
                  child: Icon(
                    isPassword ? LucideIcons.eye : LucideIcons.eyeOff,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
