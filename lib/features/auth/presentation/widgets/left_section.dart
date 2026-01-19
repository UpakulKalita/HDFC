import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/feature_item.dart';

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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/logo.webp',
                          height: 32,
                          width: 32,
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
