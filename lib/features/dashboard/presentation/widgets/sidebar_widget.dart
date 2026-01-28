import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';

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
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo Section
          Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/hdfc_logo2.png',
                    height: 28,
                    width: 28,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HDFC BANK',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          'Insurance Portal',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.95),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                            textStyle: const TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Menu Items - Scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
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
                    Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
                    const SizedBox(height: 16),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.fileText,
                      title: 'My Policies',
                      isActive: activeItem == 'My Policies',
                      color: Colors.cyan,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.helpCircle,
                      title: 'Get Help',
                      isActive: activeItem == 'Get Help',
                      color: Colors.amber,
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
                    color: Colors.white.withOpacity(0.7),
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
        color: isActive ? Colors.white.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isActive
            ? Border.all(color: Colors.white.withOpacity(0.3), width: 1)
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? Colors.white.withOpacity(0.2) : color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : color,
            size: 18,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: isActive ? Colors.white : Colors.white.withOpacity(0.9),
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
}
