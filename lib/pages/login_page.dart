import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/utils/captcha.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _captchaController = TextEditingController();

  String _captchaText = CaptchaUtils.generateCaptcha();
  bool _captchaError = false;

  void _refreshCaptcha() {
    setState(() {
      _captchaText = CaptchaUtils.generateCaptcha();
      _captchaController.clear();
      _captchaError = false;
    });
  }

  void _handleLogin() {
    if (_captchaController.text != _captchaText) {
      setState(() {
        _captchaError = true;
      });
      return;
    }

    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      // Mock Login Success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful!')),
      );
      // Navigate to next page...
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gradient Background
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF004C8F), Color(0xFF003870), Color(0xFF002850)],
          ),
        ),
        child: Stack(
          children: [
            // Background Elements (Blobs)
            const Positioned(
              top: 80,
              left: 80,
              child: _BlurBlob(size: 300, color: Color.fromRGBO(0, 76, 143, 0.2)),
            ),
            const Positioned(
              bottom: 80,
              right: 80,
              child: _BlurBlob(size: 400, color: Color.fromRGBO(0, 76, 143, 0.15)),
            ),
            const Center(
              child: _BlurBlob(size: 500, color: Color.fromRGBO(0, 76, 143, 0.1)),
            ),

            // Content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1024),
                  child: const _LoginCard(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlurBlob extends StatelessWidget {
  final double size;
  final Color color;

  const _BlurBlob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    )
    .animate(onPlay: (controller) => controller.repeat(reverse: true))
    .scaleXY(begin: 1.0, end: 1.1, duration: 4.seconds, curve: Curves.easeInOut);
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard();

  @override
  Widget build(BuildContext context) {
    // Responsive Layout
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 50,
                offset: const Offset(0, 25),
              ),
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 40,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            children: [
              // Left Section
              Expanded(
                flex: isMobile ? 0 : 1,
                child: Container(
                  height: isMobile ? null : 600,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF004C8F), Color(0xFF003870)],
                    ),
                  ),
                  child: const _LeftSection(),
                ),
              ),
              // Right Section
              Expanded(
                flex: isMobile ? 0 : 1,
                child: Container(
                  height: isMobile ? null : 600,
                  padding: const EdgeInsets.all(32),
                  child: const _LoginForm(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LeftSection extends StatelessWidget {
  const _LeftSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Decorative Circles
        Positioned(
          top: -128,
          right: -128,
          child: Container(
            width: 256,
            height: 256,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -96,
          left: -96,
          child: Container(
            width: 192,
            height: 192,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/logo.png',
                          height: 32,
                          width: 32, // Adjust based on actual aspect ratio
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'HDFC BANK',
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Insurance Portal',
                            style: GoogleFonts.inter(
                              color: Colors.blue.shade100,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Securing your future with comprehensive insurance solutions',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Colors.blue.shade100,
                    ),
                  ),
                ],
              ),

              // Features
              const SizedBox(height: 32),
              Column(
                children: const [
                  _FeatureItem(
                    icon: LucideIcons.shield,
                    title: 'Trusted Protection',
                    subtitle: '1M+ satisfied customers',
                  ),
                  SizedBox(height: 16),
                  _FeatureItem(
                    icon: LucideIcons.award,
                    title: 'Best Value Plans',
                    subtitle: 'Competitive premiums',
                  ),
                  SizedBox(height: 16),
                  _FeatureItem(
                    icon: LucideIcons.users,
                    title: 'Expert Support',
                    subtitle: '24/7 customer service',
                  ),
                ],
              ),

              const SizedBox(height: 32),
              // Footer
              Text(
                '© 2026 HDFC Bank. All rights reserved.',
                style: GoogleFonts.inter(
                  color: Colors.blue.shade100,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.blue.shade100,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  // We need access to parent state controller essentially, or lift state up.
  // For simplicity, reusing the state from parent would require passing callbacks or controllers.
  // To keep code clean, I'll access the parent `LoginPageState` or just duplicate the controllers here locally?
  // No, `LoginPage` handles state. I made `LoginPage` stateful.
  // To simplify, I will move the form UI *into* `_LoginPageState` or pass params.
  // Actually, I'll just make `_LoginForm` stateful and independent for UI, but `LoginPage` had the logic.
  // Let's refactor `LoginPage` to be the scaffold, and `_LoginCard` holds the controllers?
  // Or just pass the callback `onLogin`.

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _captchaController = TextEditingController();
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
    }
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
            fontSize: 28, // Reduced from 30
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        const SizedBox(height: 4), // Reduced from 8
        Text(
          'Enter your credentials to access the portal',
          style: GoogleFonts.inter(
            color: Colors.grey.shade600,
            fontSize: 13, // Explicitly slightly smaller
          ),
        ),
        const SizedBox(height: 24), // Reduced from 32

        // Username
        _InputField(
          label: 'Username',
          icon: LucideIcons.user,
          controller: _usernameController,
          hint: 'Enter your username',
        ),
        const SizedBox(height: 16), // Reduced from 24

        // Password
        _InputField(
          label: 'Password',
          icon: LucideIcons.lock,
          controller: _passwordController,
          hint: 'Enter your password',
          isPassword: true,
        ),
        const SizedBox(height: 16), // Reduced from 24

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Reduced vertical
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
                height: 48, // Reduced from 52
                width: 48, // Reduced from 52
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
          height: 48, // Explicit height for input to keep it compact
          child: TextField(
            controller: _captchaInputController,
            onChanged: (_) => setState(() => _captchaError = false),
            decoration: InputDecoration(
              hintText: 'Enter the captcha shown above',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16), // Vertical centered by height
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
                borderSide: const BorderSide(color: Color(0xFF004C8F), width: 2),
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

        const SizedBox(height: 20), // Reduced from 24

        // Submit Button
        SizedBox(
          width: double.infinity,
          height: 44, // Reduced from 48
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
                  colors: [Color(0xFF004C8F), Color(0xFF003870)],
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

        const SizedBox(height: 16), // Reduced from 24
        Center(
          child: Text(
            'Forgot your password?',
            style: GoogleFonts.inter(
              color: const Color(0xFF004C8F),
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
              height: 48, // Fixed height for input
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(left: 44, right: 16), // No top/bottom padding needed with fixed height
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
                    borderSide: const BorderSide(color: Color(0xFF004C8F), width: 2),
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
