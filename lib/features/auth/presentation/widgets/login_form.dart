import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/utils/captcha.dart';
import 'package:insurance_flutter/features/auth/presentation/providers/auth_provider.dart';
=======
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

>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
<<<<<<< HEAD
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

  Future<void> _handleSubmit(AuthProvider provider) async {
    // 1. Simple Captcha Check in UI first
    if (_captchaInputController.text != _captchaText) {
      setState(() {
        _captchaError = true;
      });
      return;
    }

    // 2. Call Provider Login
    final success = await provider.login(_captchaInputController.text);
    
    if (success && mounted) {
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else {
      // If failed, refresh captcha for next attempt
      _refreshCaptcha();
    }
  }

  @override
  void dispose() {
    _captchaInputController.dispose();
    super.dispose();
=======
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
    }
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
=======
    return Consumer<AuthController>(
      builder: (context, auth, _) {
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
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

            // Error Message Alert
            if (provider.errorMessage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(LucideIcons.alertCircle, color: Colors.red.shade700, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        provider.errorMessage!,
                        style: GoogleFonts.inter(
                          color: Colors.red.shade700,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Username
            _InputField(
              label: 'Username',
              icon: LucideIcons.user,
              controller: provider.usernameController,
              hint: 'Enter your username',
              errorText: provider.emailInputError,
              onChanged: (_) => provider.clearErrors(),
              enabled: !provider.isLoading && !provider.isLocked,
            ),
            const SizedBox(height: 16),

            // Password
            _InputField(
              label: 'Password',
              icon: LucideIcons.lock,
              controller: provider.passwordController,
              hint: 'Enter your password',
              isPassword: !provider.isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  provider.isPasswordVisible ? LucideIcons.eyeOff : LucideIcons.eye,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
                onPressed: provider.togglePasswordVisibility,
              ),
              onChanged: (_) => provider.clearErrors(),
              enabled: !provider.isLoading && !provider.isLocked,
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
                  onTap: provider.isLoading || provider.isLocked ? null : _refreshCaptcha,
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
                enabled: !provider.isLoading && !provider.isLocked,
                onChanged: (_) {
                  setState(() => _captchaError = false);
                  provider.clearErrors();
                },
                decoration: InputDecoration(
                  hintText: 'Enter the captcha shown above',
                  filled: true,
                  fillColor: (provider.isLoading || provider.isLocked) ? Colors.grey.shade50 : Colors.white,
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
=======
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
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272

            const SizedBox(height: 20),

            // Submit Button
<<<<<<< HEAD
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: (provider.isLoading || provider.isLocked || !provider.validateFields())
                    ? null
                    : () => _handleSubmit(provider),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, 
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.zero,
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: (provider.isLoading || provider.isLocked || !provider.validateFields())
                        ? null
                        : const LinearGradient(
                            colors: [AppColors.gradientStart, AppColors.gradientEnd],
                          ),
                    color: (provider.isLoading || provider.isLocked || !provider.validateFields())
                        ? Colors.grey.shade300
                        : null,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: (provider.isLoading || provider.isLocked || !provider.validateFields())
                        ? null
                        : const [
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
                    child: provider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
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
=======
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
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
            ),
          ],
        );
      },
    );
  }
}
<<<<<<< HEAD

class _InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final Widget? suffixIcon;
  final String? errorText;
  final Function(String)? onChanged;
  final bool enabled;

  const _InputField({
    required this.label,
    required this.icon,
    required this.controller,
    required this.hint,
    this.isPassword = false,
    this.suffixIcon,
    this.errorText,
    this.onChanged,
    this.enabled = true,
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
        TextField(
          controller: controller,
          obscureText: isPassword,
          enabled: enabled,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.shade50,
            contentPadding: const EdgeInsets.only(left: 44, right: 16),
            prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
            suffixIcon: suffixIcon,
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
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade100, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

=======
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
