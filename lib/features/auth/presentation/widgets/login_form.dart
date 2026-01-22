import 'package:flutter/material.dart';
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
      debugPrint('Login Error: $e');
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
    );
  }
}
