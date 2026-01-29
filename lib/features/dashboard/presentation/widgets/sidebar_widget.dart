import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/auth/presentation/widgets/logo_header.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';


class SidebarWidget extends StatelessWidget {
  final String activeItem;
  final Function(String) onItemTap;

  const SidebarWidget({
    super.key,
    required this.activeItem,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
            AppColors.primaryDarker,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo Section
          Container(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
            child: const LogoHeader(
              logoHeight: 28,
              titleColor: Colors.white,
              subtitleColor: Colors.white70,
            ),
          ),

          // Menu Items - Scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Divider(
                      color: Colors.white.withValues(alpha: 0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 16),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.layoutDashboard,
                      title: 'Dashboard',
                      isActive: activeItem == 'Dashboard',
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.heart,
                      title: 'Health Plans',
                      isActive: activeItem == 'Health Plans',
                      color: Colors.green,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.shield,
                      title: 'Term Life Plans',
                      isActive: activeItem == 'Term Life Plans',
                      color: Colors.purple,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.car,
                      title: 'Auto Insurance',
                      isActive: activeItem == 'Auto Insurance',
                      color: Colors.red,
                    ),
                    const SizedBox(height: 32),
                    Divider(
                      color: Colors.white.withValues(alpha: 0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 16),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.helpCircle,
                      title: 'Get Help',
                      isActive: activeItem == 'Get Help',
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 8),

                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.user,
                      title: 'My Profile',
                      isActive: activeItem == 'My Profile',
                      color: Colors.indigo,
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: Colors.white.withValues(alpha: 0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Section
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '© 2026 HDFC Bank',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool isActive = false,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.white.withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isActive
            ? Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1)
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive
                ? Colors.white.withValues(alpha: 0.2)
                : color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: isActive ? Colors.white : color, size: 18),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.9),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
        trailing: isActive
            ? Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              )
            : null,
        onTap: () => onItemTap(title),
      ),
    );
  }

  static void onTap(BuildContext context, String item) {
    switch (item) {
      case 'Dashboard':
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const DashboardPage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Health Plans':
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HealthPlansPage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Term Life Plans':
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const TermPlansPage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Auto Insurance':
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LifeInsurancePage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Get Help':
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const GetHelpPage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;

      case 'My Profile':
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ProfilePage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
    }
  }
}
