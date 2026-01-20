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
            color: AppColors.surface, // Replaced Colors.white
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              // Deep shadow for depth (using Navy instead of harsh Black)
              BoxShadow(
                color: AppColors.navyBlue.withOpacity(0.25), 
                blurRadius: 50,
                offset: const Offset(0, 25),
              ),
              // Ambient glow (using Primary Blue)
              BoxShadow(
                color: AppColors.primaryBlue.withOpacity(0.15), 
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
                    // Used the standardized gradient from AppColors
                    gradient: AppColors.primaryGradient,
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
