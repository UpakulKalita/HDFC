import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/feature_item.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/logo_header.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/section_title.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/footer_text.dart';

class LeftSection extends StatelessWidget {
  const LeftSection({super.key});

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
                  const LogoHeader(
                     titleColor: Colors.white,
                     subtitleColor: Color(0xFFBBDEFB), // Blue 100
                  ),


                  // Welcome Text
                  const SizedBox(height: 48),
                  SectionTitle(
                    title: 'Welcome Back!',
                    subtitle: 'Securing your future with comprehensive insurance solutions',
                    titleColor: Colors.white,
                    subtitleColor: Colors.blue.shade100,
                    titleFontSize: 32,
                    subtitleFontSize: 18,
                  ),
                ],
              ),

              // Features
              const SizedBox(height: 32),
              Column(
                children: const [
                  FeatureItem(
                    icon: LucideIcons.shield,
                    title: 'Trusted Protection',
                    subtitle: '1M+ satisfied customers',
                  ),
                  SizedBox(height: 16),
                  FeatureItem(
                    icon: LucideIcons.award,
                    title: 'Best Value Plans',
                    subtitle: 'Competitive premiums',
                  ),
                  SizedBox(height: 16),
                  FeatureItem(
                    icon: LucideIcons.users,
                    title: 'Expert Support',
                    subtitle: '24/7 customer service',
                  ),
                ],
              ),

              const SizedBox(height: 32),
              // Footer
              FooterText(
                text: '© 2026 HDFC Bank. All rights reserved.',
                color: Colors.blue.shade100,
                fontSize: 14,
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
