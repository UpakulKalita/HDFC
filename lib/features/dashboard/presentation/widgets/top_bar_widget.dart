import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:insurance_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';

class TopBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController? searchController;
  final bool isDesktop;
  final String activeItem;
  final String? title;
  final bool showSearch;
  final Gradient? backgroundGradient;
  final Color? backgroundColor;
  final Color? activeItemColor;
  final Widget? backgroundDecoration;
  final bool showActions;
  final double height;
  final bool automaticallyImplyLeading;
  final double titleFontSize;
  final EdgeInsetsGeometry? titlePadding;

  const TopBarWidget({
    super.key,
    this.searchController,
    required this.isDesktop,
    required this.activeItem,
    this.title,
    this.showSearch = true,
    this.backgroundGradient,
    this.backgroundColor,
    this.activeItemColor,
    this.backgroundDecoration,
    this.showActions = true,
    this.height = 70,
    this.automaticallyImplyLeading = true,
    this.titleFontSize = 24,
    this.titlePadding,
  });

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _TopBarWidgetState extends State<TopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        gradient: widget.backgroundGradient,
      ),
      child: Stack(
        children: [
          if (widget.backgroundDecoration != null) widget.backgroundDecoration!,
          AppBar(
            elevation: 0,
            toolbarHeight: widget.height,
            automaticallyImplyLeading: widget.automaticallyImplyLeading,
            backgroundColor: Colors.transparent,
            titleSpacing: widget.titlePadding != null
                ? 0
                : NavigationToolbar.kMiddleSpacing,
            leading: widget.isDesktop
                ? (widget.automaticallyImplyLeading ? null : const SizedBox())
                : Builder(
                    builder: (context) => IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: widget.activeItemColor ?? Colors.black87,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
            title: widget.showSearch
                ? Container(
                    width: widget.isDesktop ? 400 : 280,
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: widget.searchController,
                            decoration: InputDecoration(
                              hintText: widget.isDesktop
                                  ? 'Search plans, policies...'
                                  : 'Search...',
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
                  )
                : Padding(
                    padding: widget.titlePadding ?? EdgeInsets.zero,
                    child: Text(
                      widget.title ?? '',
                      style: GoogleFonts.inter(
                        fontSize: widget.titleFontSize,
                        fontWeight: FontWeight.bold,
                        color:
                            widget.activeItemColor ?? const Color(0xFF1E293B),
                      ),
                    ),
                  ),
            actions: widget.showActions
                ? [
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
                      icon: Icon(
                        Icons.person,
                        color: widget.activeItemColor ?? Colors.black87,
                        size: 20,
                      ),
                      label: MediaQuery.of(context).size.width > 500
                          ? Text(
                              'My Profile',
                              style: GoogleFonts.inter(
                                color: widget.activeItemColor ?? Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.red.shade700,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      tooltip: 'Logout',
                    ),
                    const SizedBox(width: 12),
                  ]
                : null,
          ),
        ],
      ),
    );
  }
}
