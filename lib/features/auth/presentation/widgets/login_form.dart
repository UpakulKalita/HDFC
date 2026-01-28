import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/auth/presentation/controller/auth_controller.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/recaptcha_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/section_title.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/gradient_button.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/footer_text.dart';

=======
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/utils/captcha.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
>>>>>>> origin/Ijaj

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
<<<<<<< HEAD
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
      debugPrint('Login Error: $e');
      // Verify if we need to show generic error via controller or local
    } finally {
      if (mounted) setState(() => _isLoading = false);
=======
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
>>>>>>> origin/Ijaj
    }
  }

  @override
<<<<<<< HEAD
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, auth, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Log In',
              subtitle: 'Enter your credentials to access the portal',
            ),
            const SizedBox(height: 24),

            // Username
            CustomTextField(
              label: 'Email Id',
              icon: LucideIcons.user,
              controller: auth.usernameController,
              hint: 'Enter your email id',
              errorText: auth.emailInputError,
              hasError: auth.emailInputError != null || (auth.errorMessage != null),
              onChanged: (_) => auth.clearErrors(),
            ),
            
            // Error Message
            if (auth.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  auth.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
              
            const SizedBox(height: 16),

            // Password
            CustomTextField(
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
            GradientButton(
              text: 'Log In',
              isLoading: _isLoading,
              isDisabled: auth.isLocked || !auth.validateFields(),
              onPressed: () => _handleSubmit(auth),
            ),

            const SizedBox(height: 16),
            const FooterText(
               text: 'Forgot your password?',
               alignment: Alignment.center,
            ),
          ],
        );
      },
=======
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
>>>>>>> origin/Ijaj
    );
  }
}
