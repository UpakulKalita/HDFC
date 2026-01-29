import 'package:flutter/material.dart';
import '/../core/constants/app_colors.dart';
import '../../controller/dashboard_controller.dart';
import '../navigation/dashboard_sidebar.dart';
import '../navigation/dashboard_topbar.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({
    super.key,
    required this.child,
  });

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  late final DashboardController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DashboardController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.transparent, // Allow gradient to show if needed, or just rely on Container
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                colors: [
                   Color(0xFFF0F7FF), // Very light Alice Blue
                   Color(0xFFE0F2FE), // Light Sky Blue
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ================= LEFT SIDEBAR =================
                SizedBox(
                  width: 260,
                  child: DashboardSidebar(controller: _controller),
                ),
  
                // ================= MAIN CONTENT =================
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      // ---------------- TOP BAR (Floating) ----------------
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        pinned: false,
                        backgroundColor: Colors.transparent, // Transparent to show gradient
                        surfaceTintColor: Colors.transparent,
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        toolbarHeight: 90, 
                        flexibleSpace: const FlexibleSpaceBar(
                          background: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                            child: DashboardTopBar(),
                          ),
                        ),
                      ),
  
                      // ---------------- BODY ----------------
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        sliver: SliverToBoxAdapter(
                          child: widget.child,
                        ),
                      ),
                      
                      // Bottom spacing
                      const SliverToBoxAdapter(child: SizedBox(height: 40)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
