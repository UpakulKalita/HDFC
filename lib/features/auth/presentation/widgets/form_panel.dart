import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../controller/auth_controller.dart';
import 'modern_input.dart';

class FormPanel extends StatelessWidget {
  final AuthController controller;
  final VoidCallback onLoginSuccess;

  const FormPanel({
    super.key,
    required this.controller,
    required this.onLoginSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 48),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Log In",
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B2559),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Enter your credentials to access the portal",
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 40),

                ModernInput(
                  label: "Email",
                  controller: controller.usernameController,
                  hint: "Enter your email",
                  icon: LucideIcons.user,
                ),
                const SizedBox(height: 24),

                ModernInput(
                  label: "Password",
                  controller: controller.passwordController,
                  hint: "Enter your password",
                  icon: LucideIcons.lock,
                  isPassword: true,
                ),

                const SizedBox(height: 24),

                Text(
                  "Captcha",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF374151),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          controller.captchaText.split('').join(' '),
                          style: GoogleFonts.courierPrime(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1B2559),
                            decoration: TextDecoration.lineThrough,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: controller.refreshCaptcha,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          LucideIcons.refreshCw,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: controller.captchaController,
                  decoration: InputDecoration(
                    hintText: "Enter the captcha shown above",
                    filled: true,
                    fillColor: const Color(0xFFF3F4F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFF003366),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                if (controller.captchaError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      "Incorrect captcha.",
                      style: GoogleFonts.inter(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      final validCaptcha =
                          controller.validateCaptcha();
                      final validFields =
                          controller.validateFields();

                      if (!validFields) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Please enter Email and Password")),
                        );
                        return;
                      }

                      if (!validCaptcha) return;

                      onLoginSuccess();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003366),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Log In",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot your password?",
                      style: GoogleFonts.inter(
                        color: const Color(0xFF003366),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
