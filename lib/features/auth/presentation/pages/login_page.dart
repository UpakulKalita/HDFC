import 'package:flutter/material.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/blur_blob.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/login_card.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark, AppColors.primaryDarker],
          ),
        ),
        child: Stack(
          children: [
            // Background Elements (Blobs)
            const Positioned(
              top: 80,
              left: 80,
              child: BlurBlob(size: 300, color: Color.fromRGBO(0, 76, 143, 0.2)),
            ),
            const Positioned(
              bottom: 80,
              right: 80,
              child: BlurBlob(size: 400, color: Color.fromRGBO(0, 76, 143, 0.15)),
            ),
            const Center(
              child: BlurBlob(size: 500, color: Color.fromRGBO(0, 76, 143, 0.1)),
            ),

            // Content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1024),
                  child: const LoginCard(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
