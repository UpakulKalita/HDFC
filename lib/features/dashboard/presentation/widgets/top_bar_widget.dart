import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/settings_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';

class TopBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final bool isDesktop;
  final String activeItem;


  const TopBarWidget({
    super.key,
    required this.searchController,
    required this.isDesktop,
    required this.activeItem,
  });

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _TopBarWidgetState extends State<TopBarWidget> {
  bool _isSearchExpanded = false;
  void _onSidebarItemTap(String item) {
    switch (item) {
      case 'Dashboard':
        // Already on dashboard or handle navigation
        break;
      case 'Health Plans':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HealthPlansPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Term Life Plans':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const TermPlansPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Auto Insurance':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LifeInsurancePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Get Help':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const GetHelpPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Settings':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const SettingsPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Profile':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const ProfilePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      leading: widget.isDesktop ? null : Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      automaticallyImplyLeading: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome, Sarah!',
            style: GoogleFonts.outfit( // Switched to Outfit for a more premium display look, or stick to Inter with lighter weight/larger size
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.waving_hand, color: Color(0xFFFFC107), size: 28),
        ],
      ),

      actions: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isSearchExpanded ? (widget.isDesktop ? 300 : 200) : 48,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: _isSearchExpanded ? Colors.grey.shade100 : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              if (_isSearchExpanded)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      controller: widget.searchController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 12),
                      ),
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                  ),
                ),
              IconButton(
                icon: Icon(_isSearchExpanded ? Icons.close : Icons.search, color: Colors.black87),
                onPressed: () {
                  setState(() {
                    _isSearchExpanded = !_isSearchExpanded;
                    if (!_isSearchExpanded) {
                      widget.searchController.clear();
                    }
                  });
                },
              ),
            ],
          ),
        ),
        TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const ProfilePage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
          icon: const Icon(Icons.person, color: Colors.black87, size: 20),
          label: MediaQuery.of(context).size.width > 500
              ? Text(
                  'My Profile',
                  style: GoogleFonts.inter(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.logout, color: Colors.red.shade700, size: 20),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
          tooltip: 'Logout',
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
