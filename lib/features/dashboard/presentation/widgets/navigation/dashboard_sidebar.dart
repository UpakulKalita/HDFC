import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

// Assuming these exist in your project structure
import '/../core/constants/app_colors.dart';
import '../../controller/dashboard_controller.dart';

/// ---------------------------------------------------------------------------
/// MENU MODEL
/// ---------------------------------------------------------------------------
class _MenuItemConfig {
  final String label;
  final IconData? icon; // Optional for headers
  final int? index;
  final Color? color;
  final bool isHeader;

  _MenuItemConfig({
    required this.label,
    this.icon,
    this.index,
    this.color,
    this.isHeader = false,
  });
}

/// ---------------------------------------------------------------------------
/// SIDEBAR MAIN
/// ---------------------------------------------------------------------------
class DashboardSidebar extends StatelessWidget {
  final DashboardController controller;

  const DashboardSidebar({
    super.key,
    required this.controller,
  });

  // --- MENU CONFIGURATION ---
  static final List<_MenuItemConfig> _menuItems = [
    // 1. Dashboard
    _MenuItemConfig(
      label: "Dashboard",
      icon: LucideIcons.layoutDashboard,
      index: 0,
      color: Colors.blueAccent,
    ),
    
    // 2. INSURANCE PLANS (Header)
    _MenuItemConfig(label: "INSURANCE PLANS", isHeader: true),
    
    // Items
    _MenuItemConfig(label: "Health", icon: LucideIcons.heartPulse, index: 1, color: Colors.pinkAccent),
    _MenuItemConfig(label: "Term", icon: LucideIcons.activity, index: 2, color: Colors.green),
    _MenuItemConfig(label: "Asset", icon: LucideIcons.home, index: 3, color: Colors.orange),
    _MenuItemConfig(label: "Lifestyle", icon: LucideIcons.plane, index: 4, color: Colors.purpleAccent),

    // 3. MY ACCOUNT (Header)
    _MenuItemConfig(label: "MY ACCOUNT", isHeader: true),

    // Items
    _MenuItemConfig(label: "My Policies", icon: LucideIcons.fileText, index: 5, color: Colors.cyan),
    _MenuItemConfig(label: "Claims", icon: LucideIcons.alertCircle, index: 6, color: Colors.redAccent),
    _MenuItemConfig(label: "Profile", icon: LucideIcons.userCheck, index: 7, color: Colors.indigoAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint for collapsed sidebar
        final bool isCollapsed = constraints.maxWidth < 100;
        final double width = isCollapsed ? 80 : 260;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9), // Higher opacity base
            border: const Border(
              right: BorderSide(color: Colors.white), // Subtle highlight
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.95),
                Colors.white.withOpacity(0.85),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.navyBlue.withOpacity(0.05),
                blurRadius: 30,
                offset: const Offset(4, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 18),

              // --- Logo ---
              _SidebarLogo(isCollapsed: isCollapsed),

              const SizedBox(height: 32),

              // --- Menu Items (Flexible & Scrollable if needed) ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _menuItems.map((item) {
                        if (item.isHeader) {
                           // Hide headers in collapsed mode
                           if (isCollapsed) return const SizedBox(height: 16); 
                           
                           return Padding(
                             padding: const EdgeInsets.only(top: 12, bottom: 4, left: 12),
                             child: Text(
                               item.label,
                               style: TextStyle(
                                 color: AppColors.textGrey.withOpacity(0.8),
                                 fontSize: 11,
                                 fontWeight: FontWeight.w700,
                                 letterSpacing: 1.2,
                               ),
                             ),
                           );
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: _SidebarSingleItem(
                            item: item,
                            controller: controller,
                            isCollapsed: isCollapsed,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              // --- Bottom Fixed Section ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (!isCollapsed)
                      const Divider(color: AppColors.divider, height: 32),
                    
                    // Get Help (Index 99)
                    _SidebarSingleItem(
                      item: _MenuItemConfig(
                        label: "Get Help",
                        icon: LucideIcons.headphones,
                        index: 99,
                        color: Colors.blueGrey,
                      ),
                      controller: controller,
                      isCollapsed: isCollapsed,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

/// ---------------------------------------------------------------------------
/// SINGLE SIDEBAR ITEM (For Dashboard, My Policies, Sub-items)
/// ---------------------------------------------------------------------------
class _SidebarSingleItem extends StatelessWidget {
  final _MenuItemConfig item;
  final DashboardController controller;
  final bool isCollapsed;

  const _SidebarSingleItem({
    required this.item,
    required this.controller,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = controller.selectedIndex == item.index;
    final Color itemColor = item.color ?? AppColors.primaryBlue;

    Widget tile = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: isCollapsed ? 0 : 16,
      ),
      decoration: BoxDecoration(
        // Glassmorphic Active State
        color: isSelected
            ? itemColor.withOpacity(0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? itemColor.withOpacity(0.2) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment:
            isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          // Icon
          AnimatedScale(
            scale: isSelected ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              item.icon,
              size: 22,
              color: isSelected ? itemColor : AppColors.textGrey,
            ),
          ),
          
          // Label
          if (!isCollapsed) ...[
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  color: isSelected ? AppColors.textDark : AppColors.textGrey,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            
            // Active Dot instead of Bar
            if (isSelected)
               Container(
                 width: 6,
                 height: 6,
                 decoration: BoxDecoration(
                   color: itemColor,
                   shape: BoxShape.circle,
                   boxShadow: [
                     BoxShadow(
                       color: itemColor.withOpacity(0.4),
                       blurRadius: 4,
                       spreadRadius: 1,
                     )
                   ]
                 ),
               )
          ]
        ],
      ),
    );

    // Add tooltip for collapsed mode
    if (isCollapsed) {
      tile = Tooltip(message: item.label, child: tile);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        hoverColor: itemColor.withOpacity(0.05),
        splashColor: itemColor.withOpacity(0.1),
        onTap: () {
          if (item.index != null) {
            controller.changeMenu(item.index!);
          }
        },
        child: tile,
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// LOGO
/// ---------------------------------------------------------------------------
class _SidebarLogo extends StatelessWidget {
  final bool isCollapsed;

  const _SidebarLogo({required this.isCollapsed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 0 : 24),
      child: Row(
        mainAxisAlignment:
            isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Image.asset(
            "../assets/logo.webp",
            height: isCollapsed ? 36 : 40,
            fit: BoxFit.contain,
          ),
          if (!isCollapsed) ...[
  const SizedBox(width: 12),
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // 1. Dual-Tone Title (More "Logo-like")
      RichText(
        text: TextSpan(
          text: "HDFC BANK",
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F172A),
          ),
        ),
      ),
      
      const SizedBox(height: 2),
      
      // 2. Premium Subtitle style
      // Making it Uppercase with wide spacing makes it look high-end
      const Text(
        "Insurance Portal", 
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 10,
          color: Color(0xFF94A3B8), // Slate Grey
          letterSpacing: 1.5,       // Wide spacing for elegance
        ),
      ),
    ],
  )
]
        ],
      ),
    );
  }
}