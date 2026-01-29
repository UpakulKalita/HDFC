import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/compare_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/my_policies_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/premium_calculator_page.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            AppColors.backgroundLight,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (_, _, _) => const ComparePlansPage(), transitionDuration: Duration.zero)),
            borderRadius: BorderRadius.circular(12),
            child: _buildQuickActionItem(
              icon: Icons.compare_arrows,
              title: 'Compare Plans',
              subtitle: 'Find the best coverage',
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (_, _, _) => const MyPoliciesPage(), transitionDuration: Duration.zero)),
            borderRadius: BorderRadius.circular(12),
            child: _buildQuickActionItem(
              icon: Icons.description_outlined,
              title: 'My Policies',
              subtitle: 'View your policies',
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (_, _, _) => const PremiumCalculatorPage(), transitionDuration: Duration.zero)),
            borderRadius: BorderRadius.circular(12),
            child: _buildQuickActionItem(
              icon: LucideIcons.calculator,
              title: 'Calculator',
              subtitle: 'Calculate your premiums',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.iconContainerBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey.shade300,
            size: 20,
          ),
        ],
      ),
    );
  }
}
