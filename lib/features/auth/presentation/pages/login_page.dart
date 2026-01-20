import 'package:flutter/material.dart';

import '../controller/auth_controller.dart';
import '../widgets/animated_blob.dart';
import '../widgets/login_card.dart';

import '../../../dashboard/presentation/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AuthController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLoginSuccess() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002850),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF004C8F), Color(0xFF001A33)],
              ),
            ),
          ),

          // Animated Blobs
          Positioned(
            top: -100,
            left: -100,
            child: AnimatedBlob(color: Colors.white.withOpacity(0.05)),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: AnimatedBlob(color: Colors.white.withOpacity(0.05)),
          ),

          // Login Card
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: LoginCard(
                  controller: _controller,
                  onLoginSuccess: _onLoginSuccess,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
