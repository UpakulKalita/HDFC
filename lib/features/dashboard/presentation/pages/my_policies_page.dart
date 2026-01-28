import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MyPoliciesPage extends StatefulWidget {
  const MyPoliciesPage({super.key});

  @override
  State<MyPoliciesPage> createState() => _MyPoliciesPageState();
}

class _MyPoliciesPageState extends State<MyPoliciesPage> {
  void _onSidebarItemTap(String item) {
    switch (item) {
      case 'Dashboard':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => DashboardPage(), transitionDuration: Duration.zero));
        break;
      case 'Health Plans':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const HealthPlansPage(), transitionDuration: Duration.zero));
        break;
      case 'Term Life Plans':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const TermPlansPage(), transitionDuration: Duration.zero));
        break;
      case 'Auto Insurance':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const LifeInsurancePage(), transitionDuration: Duration.zero));
        break;
      case 'Get Help':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const GetHelpPage(), transitionDuration: Duration.zero));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          if (isDesktop) SidebarWidget(activeItem: 'Dashboard', onItemTap: _onSidebarItemTap),
          Expanded(
            child: CustomScrollView(
              slivers: [
                // --- HERO SECTION ---
                SliverToBoxAdapter(
                  child: Container(
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
                              color: Colors.white.withOpacity(0.05),
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
                                onTap: () => Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const DashboardPage(), transitionDuration: Duration.zero)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(LucideIcons.arrowLeft, size: 16, color: Colors.white.withOpacity(0.8)),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Back to Dashboard',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.8),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                              const SizedBox(height: 24),
                              Text(
                                'My Policies',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: isDesktop ? 48 : 32,
                                  fontWeight: FontWeight.w800,
                                  height: 1.1,
                                ),
                              ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.1),
                              const SizedBox(height: 12),
                              Text(
                                'Manage and track all your active insurance policies in one place.',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // --- POLICIES LIST ---
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(isDesktop ? 64 : 24, 40, isDesktop ? 64 : 24, 64),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildPolicyCard(
                        context,
                        type: 'Health Insurance',
                        policyName: 'Family Floater Ultimate',
                        policyNumber: 'HDFC-HL-2024-8891',
                        status: 'Active',
                        premium: '₹12,400',
                        nextDue: '15 Mar 2025',
                        icon: Icons.health_and_safety,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 20),
                      _buildPolicyCard(
                        context,
                        type: 'Auto Insurance',
                        policyName: 'Elite Car Protect',
                        policyNumber: 'HDFC-AU-2023-4412',
                        status: 'Active',
                        premium: '₹4,200',
                        nextDue: '20 Jul 2025',
                        icon: LucideIcons.car,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 20),
                      _buildPolicyCard(
                        context,
                        type: 'Term Life',
                        policyName: 'Secure Life Plan',
                        policyNumber: 'HDFC-LF-2022-1104',
                        status: 'Active',
                        premium: '₹8,500',
                        nextDue: '10 Jan 2026',
                        icon: Icons.shield_rounded,
                        color: Colors.amber.shade700,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyCard(
    BuildContext context, {
    required String type,
    required String policyName,
    required String policyNumber,
    required String status,
    required String premium,
    required String nextDue,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background Decorative Element
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon Section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              color.withOpacity(0.15),
                              color.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: color.withOpacity(0.1)),
                        ),
                        child: Icon(icon, color: color, size: 32),
                      ),
                      const SizedBox(width: 24),
                      // Title & Status Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    type.toUpperCase(),
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: color,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.green.withOpacity(0.2)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        status,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              policyName,
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0F172A),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(LucideIcons.fingerprint, size: 14, color: Colors.grey.shade400),
                                const SizedBox(width: 6),
                                Text(
                                  'ID: $policyNumber',
                                  style: GoogleFonts.inter(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Details Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildDetailItem(
                            'Premium Amount',
                            premium,
                            LucideIcons.indianRupee,
                            color,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: const Color(0xFFE2E8F0),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: _buildDetailItem(
                              'Next Payment',
                              nextDue,
                              LucideIcons.calendarDays,
                              color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Text(
                            'View Details',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF334155),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0F172A).withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F172A),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Manage Policy',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(LucideIcons.chevronRight, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, curve: Curves.easeOut).slideY(begin: 0.1, end: 0);
  }

  Widget _buildDetailItem(String label, String value, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color.withOpacity(0.6)),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E293B),
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}
