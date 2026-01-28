import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';

class CalculatorHero extends StatelessWidget {
  const CalculatorHero({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -100,
            top: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              isDesktop ? 64 : 24,
              isDesktop ? 80 : 48,
              isDesktop ? 64 : 24,
              isDesktop ? 80 : 48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, _, _) => const DashboardPage(),
                    transitionDuration: Duration.zero,
                  )),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(LucideIcons.arrowLeft, size: 16, color: Colors.white.withValues(alpha: 0.8)),
                      const SizedBox(width: 8),
                      Text(
                        'Back to Dashboard',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.8),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.2),
                const SizedBox(height: 32),
                Text(
                  'Premium Calculator',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: isDesktop ? 56 : 36,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 50.ms).slideY(begin: 0.1),
                const SizedBox(height: 16),
                Text(
                  'Personalize your coverage and see how it affects your cost.',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
