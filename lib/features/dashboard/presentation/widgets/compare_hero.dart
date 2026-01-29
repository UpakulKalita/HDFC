import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CompareHero extends StatelessWidget {
  const CompareHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade900,
            Colors.blue.shade800,
            Colors.indigo.shade900,
          ],
        ),
      ),
      child: MaxWidthContainer(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.compare_arrows, color: Colors.blue.shade200, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'PLAN COMPARISON',
                          style: GoogleFonts.inter(
                            color: Colors.blue.shade100,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.2),
                  const SizedBox(height: 24),
                  Text(
                    'Plan Comparison',
                    style: GoogleFonts.inter(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ).animate().fadeIn(duration: 400.ms, delay: 50.ms).slideY(begin: 0.1),
                  const SizedBox(height: 12),
                  Text(
                    'Compare any two plans to see which fits your profile best.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.blue.shade100,
                      fontWeight: FontWeight.w400,
                    ),
                  ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class MaxWidthContainer extends StatelessWidget {
  final Widget child;
  const MaxWidthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: child,
      ),
    );
  }
}
