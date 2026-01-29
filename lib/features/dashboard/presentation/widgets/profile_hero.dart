import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileHero extends StatelessWidget {
  final double completion;
  final bool isDesktop;
  final VoidCallback onBackTap;
  final VoidCallback onSaveTap;

  const ProfileHero({
    super.key,
    required this.completion,
    required this.isDesktop,
    required this.onBackTap,
    required this.onSaveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 64 : 24,
              vertical: isDesktop ? 80 : 48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onBackTap,
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

                const SizedBox(height: 24),
                Text(
                  'My Personal Profile',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ).animate().fadeIn(duration: 300.ms, delay: 50.ms).slideX(begin: -0.2),

                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Account Details',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: isDesktop ? 48 : 32,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: 50.ms).slideY(begin: 0.1),

                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: onSaveTap,
                      icon: Icon(LucideIcons.save, size: 18, color: AppColors.primary),
                      label: const Text('Save Changes'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                        textStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ).animate().fadeIn(duration: 300.ms, delay: 100.ms),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
