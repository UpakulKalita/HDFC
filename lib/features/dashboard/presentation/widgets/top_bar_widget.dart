import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:insurance_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
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
  Size get preferredSize => const Size.fromHeight(70);
}

class _TopBarWidgetState extends State<TopBarWidget> {
  void _onSidebarItemTap(String item) {
    switch (item) {
      case 'Dashboard':
        // Already on dashboard or handle navigation
        break;
      case 'Health Plans':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const HealthPlansPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Term Life Plans':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const TermPlansPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Auto Insurance':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const LifeInsurancePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Get Help':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const GetHelpPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Profile':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const ProfilePage(),
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
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      leading: widget.isDesktop ? null : Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Container(
        width: widget.isDesktop ? 400 : 280,
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey.shade600, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: widget.searchController,
                decoration: InputDecoration(
                  hintText: widget.isDesktop ? 'Search customers, policies...' : 'Search...',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                style: GoogleFonts.inter(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, _, _) => const ProfilePage(),
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
