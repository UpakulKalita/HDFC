import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/settings_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/top_bar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/compare_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/my_policies_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/premium_calculator_page.dart';
import 'package:insurance_flutter/features/coverage_analysis/presentation/widgets/coverage_analysis_widget.dart';

enum DashboardPageType {
  dashboard,
  healthPlans,
  termPlans,
  lifeInsurance,
  homeInsurance,
  autoInsurance,
  getHelp,
  settings,
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
      case 'My Policies':
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const MyPoliciesPage(),
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
                        child: _buildCurrentPageContent(isDesktop, screenWidth),
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

  Widget _buildWelcomeCard(double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: screenWidth < 600
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.waving_hand,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Welcome, Sarah!',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Here\'s what\'s happening with your insurance today.',
                  style: GoogleFonts.inter(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.waving_hand,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, Sarah!',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Here\'s what\'s happening with your insurance today.',
                        style: GoogleFonts.inter(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  /* ================= STATS CARDS ================= */



  /* ================= QUICK ACTIONS ================= */

  Widget _buildQuickActionsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: [
               InkWell(
                onTap: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const ComparePlansPage(), transitionDuration: Duration.zero)),
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: _buildQuickActionCard(
                    icon: Icons.compare_arrows_rounded,
                    title: 'Compare Plans',
                    subtitle: 'Find best fit',
                    color: Colors.blue,
                  ),
                ),
              ),
               const SizedBox(height: 10),
               InkWell(
                onTap: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const PremiumCalculatorPage(), transitionDuration: Duration.zero)),
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: _buildQuickActionCard(
                    icon: Icons.calculate_rounded,
                    title: 'Calculator',
                    subtitle: 'Estimate cost',
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [color.withOpacity(0.12), Colors.transparent],
                ),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.grey[300],
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* ================= RECOMMENDATION BULLET ================= */

  Widget _buildRecommendationBullet(String text, {bool isModern = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isModern ? const Color(0xFF4CAF50).withOpacity(0.5) : Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF475569),
                fontWeight: isModern ? FontWeight.w500 : FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ================= RECOMMENDATIONS SECTION ================= */

  Widget _buildRecommendationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommendations for You',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Based on your profile and current coverage',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 24),

        // -------- RECOMMENDATIONS GRID --------
        LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth;
            if (constraints.maxWidth > 1100) {
              cardWidth = (constraints.maxWidth - 48) / 3;
            } else if (constraints.maxWidth > 700) {
              cardWidth = (constraints.maxWidth - 24) / 2;
            } else {
              cardWidth = constraints.maxWidth;
            }

            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: DashboardPlanCard(
                    type: 'Health',
                    typeColor: const Color(0xFF4CAF50),
                    title: 'Smart Health Plus',
                    price: '₹2,499/mo',
                    coverage: '₹5 Lakhs',
                    claimRatio: '98.5%',
                    waitingPeriod: '2 Yrs',
                    features: [
                      'Covers 100% of hospitalization expenses.',
                      'Includes dental and vision care treatments.',
                      'Full support for mental well-being.',
                      'Access to doctors 24/7 anytime.',
                    ],
                    tags: ['Tax Saver', 'No Medical Test'],
                    imageUrl: 'https://images.unsplash.com/photo-1516549655169-df83a0774514?auto=format&fit=crop&q=80&w=600',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: DashboardPlanCard(
                    type: 'Term Life',
                    typeColor: Colors.blue,
                    title: 'Superior Life Plan',
                    price: '₹1,899/mo',
                    coverage: '₹1 Crore',
                    claimRatio: '99.1%',
                    waitingPeriod: 'Nil',
                    features: [
                      'High-value term life insurance with critical rider.',
                      'Lump sum payout on terminal illness.',
                      'Tax benefits under Section 80C.',
                      'Flexible premium payment terms.',
                    ],
                    tags: ['Best Seller', 'High Cover'],
                    imageUrl: 'https://images.unsplash.com/photo-1576091160550-217359f488d5?auto=format&fit=crop&q=80&w=600',
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: DashboardPlanCard(
                    type: 'Health',
                    typeColor: const Color(0xFF4CAF50),
                    title: 'Critical Care Plus',
                    price: '₹2,999/mo',
                    coverage: '₹10 Lakhs',
                    claimRatio: '98.8%',
                    waitingPeriod: '1 Yr',
                    features: [
                      'Advanced protection for critical illnesses.',
                      'Covers 32 major critical illnesses.',
                      'Cashless treatment at 10k+ hospitals.',
                      'Alternative medicine (AYUSH) cover.',
                    ],
                    tags: ['Comprehensive', 'Critical Care'],
                    imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=600',
                  ),
                ),
              ],
            );
          },
        ),

      ],
    );
  }


  /* ================= CURRENT PAGE CONTENT ================= */

  Widget _buildCurrentPageContent(bool isDesktop, double screenWidth) {
    bool useVerticalLayout = screenWidth < 1000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (useVerticalLayout)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const CoverageAnalysisWidget()
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: 0.2),
              const SizedBox(height: 24),
              _buildQuickActionsCard()
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
                    const CoverageAnalysisWidget()
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 200.ms)
                        .slideY(begin: 0.2),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 1,
                child: _buildQuickActionsCard()
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 400.ms)
                    .slideY(begin: 0.2),
              ),
            ],
          ),
        const SizedBox(height: 32),
        _buildRecommendationsSection()
            .animate()
            .fadeIn(duration: 600.ms, delay: 600.ms)
            .slideY(begin: 0.2),
      ],
    );
  }
}

class DashboardPlanCard extends StatefulWidget {
  final String type;
  final Color typeColor;
  final String title;
  final String price;
  final String coverage;
  final String claimRatio;
  final String waitingPeriod;
  final List<String> features;
  final List<String> tags;
  final String imageUrl;

  const DashboardPlanCard({
    super.key,
    required this.type,
    required this.typeColor,
    required this.title,
    required this.price,
    required this.coverage,
    required this.claimRatio,
    required this.waitingPeriod,
    required this.features,
    required this.tags,
    required this.imageUrl,
  });

  @override
  State<DashboardPlanCard> createState() => _DashboardPlanCardState();
}

class _DashboardPlanCardState extends State<DashboardPlanCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: _isHovered ? Matrix4.identity().scaled(1.02) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? widget.typeColor.withOpacity(0.3) : Colors.grey.shade200,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.typeColor.withOpacity(_isHovered ? 0.15 : 0.05),
              blurRadius: _isHovered ? 24 : 16,
              offset: Offset(0, _isHovered ? 12 : 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Header with Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Image.network(
                    widget.imageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [widget.typeColor.withOpacity(0.1), widget.typeColor.withOpacity(0.2)],
                          ),
                        ),
                        child: Icon(
                          widget.type.contains('Health') ? Icons.health_and_safety : Icons.shield,
                          color: widget.typeColor,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
                // Recommended Badge
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [widget.typeColor, widget.typeColor.withBlue(widget.typeColor.blue + 20).withGreen(widget.typeColor.green + 20)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          'Recommended',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tags
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildTypeTag(widget.type, widget.typeColor),
                      ...widget.tags.map((tag) => _buildTextTag(tag)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Title
                  Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatTile('Coverage', widget.coverage, Icons.shield_outlined, widget.typeColor),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatTile('Claims', widget.claimRatio, Icons.verified_user_outlined, widget.typeColor),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatTile('Waiting', widget.waitingPeriod, Icons.hourglass_empty_rounded, widget.typeColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 16),
                  
                  // Why Recommended
                  Text(
                    'Why Recommended',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.features.take(2).map((feature) => _buildBullet(feature)),
                  
                  const SizedBox(height: 20),
                  
                  // Price and Button
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.price,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            Text(
                              'billed annually',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.typeColor,
                        foregroundColor: Colors.white,
                        elevation: _isHovered ? 4 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'View Plan',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
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
    );
  }

  Widget _buildTypeTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Widget _buildTextTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF64748B),
        ),
      ),
    );
  }

  Widget _buildStatTile(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 10, color: color.withOpacity(0.7)),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF1E293B),
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: widget.typeColor.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF475569),
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
