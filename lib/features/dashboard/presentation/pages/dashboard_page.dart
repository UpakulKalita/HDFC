import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart'; // Import Provider
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/top_bar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/my_policies_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/welcome_card.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/quick_actions_card.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/protection_score_card.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/recommendations_section.dart';

enum DashboardPageType {
  dashboard,
  healthPlans,
  termPlans,
  lifeInsurance,
  homeInsurance,
  autoInsurance,
  getHelp,
  profile,
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();



  DashboardPageType _currentPage = DashboardPageType.dashboard;

  @override
  void initState() {
    super.initState();
    // Fetch data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadDashboardData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }



  void _onSidebarItemTap(String item) {
    switch (item) {
      case 'Dashboard':
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
      case 'My Policies':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const MyPoliciesPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'My Profile':
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              if (isDesktop)
                SidebarWidget(
                  activeItem: 'Dashboard',
                  onItemTap: _onSidebarItemTap,
                ),
              Expanded(
                child: Column(
                  children: [
                    TopBarWidget(
                      searchController: _searchController,
                      isDesktop: isDesktop,
                      activeItem: 'Dashboard',
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        padding: EdgeInsets.all(isDesktop ? 32 : 16),
                        child: Consumer<DashboardProvider>(
                          builder: (context, provider, child) {
                            if (provider.isLoading) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height * 0.7,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Loading',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF64748B),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      ...List.generate(3, (index) => 
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 1.5),
                                          child: Text(
                                            '.',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w800,
                                              color: index == 0 ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                                            ),
                                          ).animate(onPlay: (c) => c.repeat())
                                           .fadeIn(duration: 200.ms, delay: (index * 100).ms)
                                           .then(delay: 400.ms)
                                           .fadeOut(duration: 150.ms),
                                        ),

                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            if (provider.error != null) {
                              return Center(
                                child: Text('Error: ${provider.error}'),
                              );
                            }

                            return _buildCurrentPageContent(isDesktop, screenWidth, provider);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
      drawer: isDesktop
          ? null
          : SidebarWidget(
              activeItem: 'Dashboard',
              onItemTap: _onSidebarItemTap,
            ),
    );
  }



  /* ================= WELCOME CARD ================= */



  /* ================= STATS CARDS ================= */



  /* ================= QUICK ACTIONS ================= */


  /* ================= CURRENT PAGE CONTENT ================= */

  Widget _buildCurrentPageContent(bool isDesktop, double screenWidth, DashboardProvider provider) {
    bool useVerticalLayout = screenWidth < 1000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (useVerticalLayout)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeCard()
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.2),
              const SizedBox(height: 24),
              ProtectionScoreCard(metrics: provider.metrics)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: 0.2),
              const SizedBox(height: 24),
              QuickActionsCard()
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .slideY(begin: 0.2),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeCard()
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.2),
                    const SizedBox(height: 32),
                    ProtectionScoreCard(metrics: provider.metrics)
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 200.ms)
                        .slideY(begin: 0.2),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: QuickActionsCard()
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 400.ms)
                    .slideY(begin: 0.2),
              ),
            ],
          ),
        const SizedBox(height: 32),
        RecommendationsSection(recommendations: provider.recommendations)
            .animate()
            .fadeIn(duration: 600.ms, delay: 600.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 80),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              '© 2026 HDFC Bank. All rights reserved.',
              style: GoogleFonts.inter(
                color: Colors.grey.shade400,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
=======

import '../widgets/layout/dashboard_layout.dart';
import '../widgets/content/dashboard_home_content.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardLayout(
      child: DashboardHomeContent(),
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
    );
  }
}
