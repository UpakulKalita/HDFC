import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/core/theme/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;

class DashboardTopBar extends StatefulWidget {
  const DashboardTopBar({super.key});

  @override
  State<DashboardTopBar> createState() => _DashboardTopBarState();
}

class _DashboardTopBarState extends State<DashboardTopBar> {
  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
    });
    if (_isSearchExpanded) {
      _searchFocus.requestFocus();
    } else {
      _searchFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < 800;
        final bool isVerySmall = constraints.maxWidth < 500;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ---------------- GREETING (LEFT) ----------------
            if (!(_isSearchExpanded && isCompact))
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Hi, ",
                                  style: TextStyle(
                                    fontSize: isVerySmall ? 18 : 22,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.navyBlue,
                                    letterSpacing: -0.5,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                  ),
                                ),
                                TextSpan(
                                  text: "IJAJ",
                                  style: TextStyle(
                                    fontSize: isVerySmall ? 18 : 22,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.navyBlue,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isVerySmall) ...[
                            const SizedBox(height: 3),
                            const Text(
                              "Welcome back to your dashboard",
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),

             if (_isSearchExpanded && isCompact) const Spacer(),

            // ---------------- ACTIONS (RIGHT) ----------------
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ---------------- SEARCH BUTTON ----------------
                AnimatedContainer(
                  duration: AppColors.durationMedium,
                  curve: Curves.easeOutCubic,
                  width: _isSearchExpanded ? (isCompact ? 240 : 400) : 48,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.surface.withOpacity(0.95),
                        AppColors.surface.withOpacity(0.85),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.navyBlue.withOpacity(_isSearchExpanded ? 0.1 : 0.05),
                        blurRadius: _isSearchExpanded ? 20 : 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: _isSearchExpanded 
                          ? AppColors.primaryBlue.withOpacity(0.3) 
                          : AppColors.surface.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Search Icon Button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _toggleSearch,
                          borderRadius: BorderRadius.circular(30),
                          child: SizedBox(
                            width: 48,
                            height: 46, 
                            child: Icon(
                              _isSearchExpanded ? LucideIcons.x : LucideIcons.search,
                              size: 20,
                              color: _isSearchExpanded ? AppColors.navyBlue : AppColors.textDark,
                            ),
                          ),
                        ),
                      ),

                      // Collapsible Text Field
                      Expanded(
                        child: AnimatedOpacity(
                          duration: AppColors.durationShort,
                          opacity: _isSearchExpanded ? 1.0 : 0.0,
                          child: _isSearchExpanded
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: TextField(
                                    controller: _searchController,
                                    focusNode: _searchFocus,
                                    decoration: const InputDecoration(
                                      hintText: "Search policies, claims...",
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      hintStyle: TextStyle(fontSize: 14, color: AppColors.textLight),
                                    ),
                                    style: const TextStyle(fontSize: 14, color: AppColors.textDark),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // ---------------- ALERTS BUTTON ----------------
                _AlertsButton(),

                const SizedBox(width: 12),

                // ---------------- PROFILE PILL ----------------
                _ProfilePill(isCompact: isCompact),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _AlertsButton extends StatefulWidget {
  @override
  State<_AlertsButton> createState() => _AlertsButtonState();
}

class _AlertsButtonState extends State<_AlertsButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: AppColors.durationShort,
          width: 48, 
          height: 46, 
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surface.withOpacity(0.95),
                AppColors.surface.withOpacity(0.85),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovering ? AppColors.navyBlue.withOpacity(0.2) : AppColors.surface.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.navyBlue.withOpacity(_isHovering ? 0.1 : 0.05),
                blurRadius: _isHovering ? 15 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                LucideIcons.bell,
                size: 20, 
                color: _isHovering ? AppColors.primaryBlue : AppColors.textDark,
              ),
              // Notification Dot
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.error, // Replaced Colors.red
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfilePill extends StatefulWidget {
  final bool isCompact;

  const _ProfilePill({required this.isCompact});

  @override
  State<_ProfilePill> createState() => _ProfilePillState();
}

class _ProfilePillState extends State<_ProfilePill> {
  bool _isHovering = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleMenu() {
    if (_isMenuOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isMenuOpen = false);
  }

  void _showOverlay() {
    setState(() => _isMenuOpen = true);
    final overlay = Overlay.of(context);
    
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Close on click outside
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _removeOverlay,
              child: const SizedBox(),
            ),
          ),
          Positioned(
            width: 140, // Width of the menu
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 50), // Position below pill
              child: Material(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.surface.withOpacity(0.5),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.navyBlue.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              _removeOverlay();
                              // Add Sign Out Logic Here
                              print("Sign Out Clicked");
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                children: const [
                                  Icon(LucideIcons.logOut, size: 16, color: AppColors.error),
                                  SizedBox(width: 8),
                                  Text(
                                    "Sign Out",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.error,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: InkWell(
          onTap: _toggleMenu,
          borderRadius: BorderRadius.circular(30),
          child: AnimatedContainer(
            duration: AppColors.durationShort,
            height: 46, // Match height of Search/Alert buttons
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.surface.withOpacity(0.95),
                  AppColors.surface.withOpacity(0.85),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                 color: _isHovering || _isMenuOpen ? AppColors.navyBlue.withOpacity(0.2) : AppColors.surface.withOpacity(0.5)
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navyBlue.withOpacity(_isHovering || _isMenuOpen ? 0.1 : 0.05),
                  blurRadius: _isHovering || _isMenuOpen ? 15 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar
                AnimatedContainer(
                  duration: AppColors.durationShort,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isHovering || _isMenuOpen ? AppColors.primaryBlue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 14, 
                    backgroundColor: AppColors.navyBlue,
                    child: const Text(
                      "IJ",
                      style: TextStyle(
                        color: AppColors.surface, // Used surface (white) for contrast on Navy
                        fontSize: 11, 
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                if (!widget.isCompact) ...[
                  const SizedBox(width: 8),
                  
                  // Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Ishaan J.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(width: 6),
                  
                  // Arrow
                  AnimatedRotation(
                    turns: _isMenuOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: _isHovering || _isMenuOpen ? AppColors.primaryBlue : AppColors.textGrey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
