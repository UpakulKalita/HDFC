import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'hdfc_logo.dart';
import 'feature_item.dart';

class BrandPanel extends StatelessWidget {
  const BrandPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: const BoxDecoration(
        color: Color(0xFF003366),
        image: DecorationImage(
          image: NetworkImage(
              "https://www.transparenttextures.com/patterns/cubes.png"),
          opacity: 0.05,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HdfcLogo(),

          const Spacer(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back!",
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Securing your future with comprehensive insurance solutions",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),

              const FeatureItem(
                icon: LucideIcons.shieldCheck,
                title: "Trusted Protection",
                subtitle: "1M+ satisfied customers",
              ),
              const SizedBox(height: 24),
              const FeatureItem(
                icon: LucideIcons.percent,
                title: "Best Value Plans",
                subtitle: "Competitive premiums",
              ),
              const SizedBox(height: 24),
              const FeatureItem(
                icon: LucideIcons.headphones,
                title: "Expert Support",
                subtitle: "24/7 customer service",
              ),
            ],
          ),

          const Spacer(),

          Text(
            "© 2026 HDFC Bank. All rights reserved.",
            style: GoogleFonts.inter(
              color: Colors.white38,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
