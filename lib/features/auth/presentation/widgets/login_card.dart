import 'package:flutter/material.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/left_section.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/login_form.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

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
<<<<<<< HEAD
                color: Colors.black.withValues(alpha: 0.5),
=======
                color: Colors.black.withOpacity(0.5),
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
                blurRadius: 50,
                offset: const Offset(0, 25),
              ),
              BoxShadow(
<<<<<<< HEAD
                color: Colors.blue.withValues(alpha: 0.3),
=======
                color: Colors.blue.withOpacity(0.3),
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
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
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                    ),
                  ),
                  child: const LeftSection(),
                ),
              ),
              // Right Section
              Expanded(
                flex: isMobile ? 0 : 1,
                child: Container(
                  height: isMobile ? null : 600,
                  padding: const EdgeInsets.all(32),
                  child: const LoginForm(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
