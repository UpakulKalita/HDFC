import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/settings_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';

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
  bool _isNotificationSidebarOpen = false;
  DashboardPageType _currentPage = DashboardPageType.dashboard;

  void _onSidebarItemTap(String item) {
    // Handle navigation based on the selected item
    switch (item) {
      case 'Dashboard':
        // Already on this page
        break;
      case 'Health Plans':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => HealthPlansPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Term Plans':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => TermPlansPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Home Insurance':
        // TODO: Navigate to Home Insurance page
        break;
      case 'Auto Insurance':
        // TODO: Navigate to Auto Insurance page
        break;
      case 'Life Insurance':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => LifeInsurancePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Get Help':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => GetHelpPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Settings':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => SettingsPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Profile':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;
    final isTablet = screenWidth >= 600 && screenWidth < 800;
    final isMobile = screenWidth < 600;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.grey.shade50,
            child: Row(
              children: [
                if (isDesktop) ...[
                  /// LEFT SIDEBAR - Full Height (Desktop only)
                  SidebarWidget(
                    activeItem: 'Dashboard',
                    onItemTap: _onSidebarItemTap,
                  ),
                ],

                /// MAIN CONTENT AREA
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        )),
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      key: ValueKey<DashboardPageType>(_currentPage),
                      children: [
                        /// TOP BAR
                        _buildTopBar(context, isDesktop: isDesktop),

                        /// MAIN CONTENT
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(32),
                              child: Container(
                                constraints: const BoxConstraints(maxWidth: 1400),
                                child: _buildCurrentPageContent(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// NOTIFICATION SIDEBAR - Right side overlay
          if (_isNotificationSidebarOpen)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isNotificationSidebarOpen = false;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                color: Colors.black.withOpacity(0.5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutBack,
                    transform: Matrix4.translationValues(
                      _isNotificationSidebarOpen ? 0 : 400,
                      0,
                      0,
                    ),
                    child: _buildNotificationSidebar(context),
                  ),
                ),
              ),
            ),



        ],
      ),
      drawer: isDesktop ? null : SidebarWidget(
        activeItem: 'Dashboard',
        onItemTap: _onSidebarItemTap,
      ),
    );
  }

  /* ================= SIDEBAR ================= */

  Widget _buildSidebar(BuildContext context) {
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
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.08),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.grey.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/hdfc_logo2.png',
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.blue.shade100,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          'HDFC INSURE',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1.2,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Insurance Portal',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
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
                      isActive: true,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.heart,
                      title: 'Health Plans',
                      color: Colors.green,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.shield,
                      title: 'Term Plans',
                      color: Colors.purple,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.home,
                      title: 'Home Insurance',
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.car,
                      title: 'Auto Insurance',
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.umbrella,
                      title: 'Life Insurance',
                      color: Colors.red,
                    ),
                    const SizedBox(height: 32),
                    Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
                    const SizedBox(height: 16),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.helpCircle,
                      title: 'Get Help',
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.settings,
                      title: 'Settings',
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    _sidebarMenuItem(
                      context,
                      icon: LucideIcons.user,
                      title: 'Profile',
                      color: Colors.indigo,
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
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.lightbulb,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Need assistance? Contact our support team.',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
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
        onTap: () => _onSidebarItemTap(title),
      ),
    );
  }

  /* ================= TOP BAR ================= */

  AppBar _buildTopBar(BuildContext context, {required bool isDesktop}) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      leading: isDesktop ? null : Builder(
        builder: (context) => IconButton(
          icon: const Icon(LucideIcons.menu, color: Colors.black87),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Container(
        width: isDesktop ? 400 : 280, // Responsive width for search bar - made wider
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(LucideIcons.search,
                color: Colors.grey.shade600, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: isDesktop ? 'Search customers, policies...' : 'Search...',
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
        // Notification Button with Red Dot
        Stack(
          children: [
            IconButton(
              icon: Icon(LucideIcons.bell, color: Colors.black87, size: 24),
              onPressed: () {
                setState(() {
                  _isNotificationSidebarOpen = !_isNotificationSidebarOpen;
                });
              },
              tooltip: 'Notifications',
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '3',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // My Profile Button
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.person, color: Colors.black87, size: 20),
          label: Text(
            'My Profile',
            style: GoogleFonts.inter(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Styled Logout Button
        Container(
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(LucideIcons.logOut, color: Colors.red.shade700, size: 20),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            tooltip: 'Logout',
            padding: const EdgeInsets.all(8),
          ),
        ),
      ],
    );
  }

  /* ================= WELCOME CARD ================= */

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
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
                  'Welcome Back, Sarah!',
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

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.policy,
            title: 'Active Policies',
            value: '2',
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.account_balance_wallet,
            title: 'No. of recommanded Policies',
            value: '3',
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.trending_up,
            title: 'No. of dependents',
            value: '4',
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.w400,
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
        Row(
          children: [
            Expanded(
              child: _buildRecommendationCard(
                type: 'Health',
                typeColor: Colors.green,
                title: 'Smart Health Plus',
                description: 'Coverage with wellness benefits',
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildRecommendationCard(
                type: 'Life',
                typeColor: Colors.blue,
                title: 'Secure Life Cover',
                description: 'Term life insurance with critical illness rider',
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildRecommendationCard(
                type: 'Life',
                typeColor: Colors.blue,
                title: 'Future Guardian',
                description: 'Whole life coverage with investment benefits',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecommendationCard({
    required String type,
    required Color typeColor,
    required String title,
    required String description,
  }) {
    // Define gradient colors based on insurance type
    final List<Color> gradientColors = type == 'Health'
        ? [Colors.green.shade50, Colors.teal.shade50] // Light green → mint
        : [Colors.blue.shade50, Colors.purple.shade50]; // Light blue → lavender

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle gradient background shape (top-right corner)
          Positioned(
            top: -20,
            right: -20,
            child: Opacity(
              opacity: 0.12, // Very low opacity (8-15%)
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors,
                  ),
                ),
              ),
            ),
          ),

          // Card Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo and Health/Life badge in same line
              Row(
                children: [
                  // Icon container with subtle tint
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      type == 'Health' ? Icons.health_and_safety : Icons.shield,
                      color: typeColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Small badge label
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      type.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: typeColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Bold plan title
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // Coverage detail with check icon
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: typeColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      description,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Coverage Score/Gap
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: typeColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      type == 'Health' ? Icons.health_and_safety : Icons.shield,
                      color: typeColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Coverage Gap: ₹1.2L',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Score: 78/100',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Why Recommended
              Text(
                'Why Recommended',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRecommendationBullet('Comprehensive coverage for family needs'),
                  _buildRecommendationBullet('Low premium with high claim settlement ratio'),
                  _buildRecommendationBullet('Includes critical illness coverage'),
                  _buildRecommendationBullet('24/7 customer support available'),
                ],
              ),
              const SizedBox(height: 20),

              // Very subtle divider line
              Container(
                height: 1,
                color: Colors.grey.shade200,
              ),
              const SizedBox(height: 16),

              // Price section
              Text(
                'Starting from ₹2,499/month',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Primary CTA button with matching accent color
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: typeColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    'View Details',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /* ================= QUICK ACTIONS CARD ================= */

  Widget _buildQuickActionsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildQuickActionItem(
            icon: Icons.compare_arrows,
            title: 'Compare Plans',
            subtitle: 'Find the best coverage',
          ),
          const SizedBox(height: 12),
          _buildQuickActionItem(
            icon: Icons.policy,
            title: 'My Policies',
            subtitle: 'View all policies',
          ),
          const SizedBox(height: 12),
          _buildQuickActionItem(
            icon: Icons.calculate,
            title: 'Premium Calculator',
            subtitle: 'Calculate your premiums',
          ),
          const SizedBox(height: 12),
          _buildQuickActionItem(
            icon: Icons.help,
            title: 'FAQs',
            subtitle: 'Quick answers',
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[400],
            size: 16,
          ),
        ],
      ),
    );
  }







  /* ================= INSURANCE RECOMMENDATIONS ================= */

  Widget _buildInsuranceRecommendations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Insurance Plans',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Personalized recommendations based on your profile',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // Action Buttons
            Row(
              children: [
                _buildActionButton(
                  icon: Icons.filter_list,
                  label: 'Filter',
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                _buildActionButton(
                  icon: Icons.sort,
                  label: 'Sort',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Card Grid Layout - First Row
        Row(
          children: [
            Expanded(
              child: _buildInsuranceCard(
                icon: Icons.health_and_safety,
                iconColor: Colors.green,
                title: 'Health Shield Pro',
                subtitle: 'Comprehensive coverage',
                monthlyPrice: '₹2,499',
                yearlyPrice: '₹29,988',
                features: [
                  'Hospitalization coverage',
                  'Dental & vision care',
                  'Mental health support',
                ],
                isRecommended: true,
                delay: 0,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildInsuranceCard(
                icon: Icons.directions_car,
                iconColor: Colors.blue,
                title: 'Auto Complete',
                subtitle: 'Full vehicle protection',
                monthlyPrice: '₹1,299',
                yearlyPrice: '₹15,588',
                features: [
                  'Third party liability',
                  'Own damage coverage',
                  '24/7 roadside assistance',
                ],
                isRecommended: false,
                delay: 100,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildInsuranceCard(
                icon: Icons.home,
                iconColor: Colors.orange,
                title: 'Home Guardian',
                subtitle: 'Property & contents',
                monthlyPrice: '₹899',
                yearlyPrice: '₹10,788',
                features: [
                  'Structure coverage',
                  'Personal belongings',
                  'Natural disaster protection',
                ],
                isRecommended: false,
                delay: 200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Second Row - Three More Cards
        Row(
          children: [
            Expanded(
              child: _buildInsuranceCard(
                icon: Icons.shield,
                iconColor: Colors.purple,
                title: 'Life Protector Plus',
                subtitle: 'Term life insurance',
                monthlyPrice: '₹1,599',
                yearlyPrice: '₹19,188',
                features: [
                  'High coverage amount',
                  'Flexible term options',
                  'Critical illness rider',
                ],
                isRecommended: false,
                delay: 300,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildInsuranceCard(
                icon: Icons.business,
                iconColor: Colors.teal,
                title: 'Business Shield',
                subtitle: 'Commercial insurance',
                monthlyPrice: '₹3,499',
                yearlyPrice: '₹41,988',
                features: [
                  'Property & liability',
                  'Business interruption',
                  'Employee coverage',
                ],
                isRecommended: false,
                delay: 400,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildInsuranceCard(
                icon: Icons.flight,
                iconColor: Colors.indigo,
                title: 'Travel Guard',
                subtitle: 'International coverage',
                monthlyPrice: '₹699',
                yearlyPrice: '₹8,388',
                features: [
                  'Trip cancellation',
                  'Medical emergency',
                  'Lost baggage coverage',
                ],
                isRecommended: false,
                delay: 500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Explore More Button
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Explore More Plans',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.primary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String monthlyPrice,
    required String yearlyPrice,
    required List<String> features,
    required bool isRecommended,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isRecommended
            ? Border.all(color: iconColor.withOpacity(0.3), width: 2)
            : Border.all(color: Colors.grey[200]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section with Icon and Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon Container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              // Recommendation Badge
              if (isRecommended)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Recommended',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Title and Subtitle
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),

          // Pricing
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '₹$monthlyPrice',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'per month • ₹$yearlyPrice yearly',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Features List
          Column(
            children: features.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: iconColor,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // CTA Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isRecommended ? iconColor : Colors.grey[100],
                foregroundColor: isRecommended ? Colors.white : Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: isRecommended ? 2 : 0,
              ),
              child: Text(
                'Get Started',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: delay.ms).slideY(begin: 0.1);
  }



  /* ================= NOTIFICATION SIDEBAR ================= */

  Widget _buildNotificationSidebar(BuildContext context) {
    return Container(
      width: 380,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.grey.shade50,
            Colors.grey.shade100,
          ],
        ),
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(-5, 0),
          ),
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(-10, 0),
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Enhanced Header with Gradient
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.zero,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        LucideIcons.bell,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Stay updated',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.grey.shade600, size: 18),
                    onPressed: () {
                      setState(() {
                        _isNotificationSidebarOpen = false;
                      });
                    },
                    tooltip: 'Close',
                    padding: const EdgeInsets.all(6),
                  ),
                ),
              ],
            ),
          ),

          // Enhanced Notifications List
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.grey.shade50.withOpacity(0.3),
                  ],
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildNotificationItem(
                    icon: Icons.policy,
                    title: 'Policy Renewal Reminder',
                    message: 'Your health insurance policy expires in 7 days. Renew now to avoid coverage gaps.',
                    time: '2 hours ago',
                    isUnread: true,
                  ),
                  const SizedBox(height: 12),
                  _buildNotificationItem(
                    icon: Icons.payment,
                    title: 'Payment Successful',
                    message: 'Your premium payment of ₹2,499 has been processed successfully.',
                    time: '1 day ago',
                    isUnread: true,
                  ),
                  const SizedBox(height: 12),
                  _buildNotificationItem(
                    icon: Icons.assignment_turned_in,
                    title: 'Claim Approved',
                    message: 'Your medical claim for ₹15,000 has been approved and will be credited within 2-3 business days.',
                    time: '2 days ago',
                    isUnread: false,
                  ),
                  const SizedBox(height: 12),
                  _buildNotificationItem(
                    icon: Icons.update,
                    title: 'Policy Update',
                    message: 'New coverage options have been added to your existing policy. Review the changes.',
                    time: '3 days ago',
                    isUnread: false,
                  ),
                  const SizedBox(height: 12),
                  _buildNotificationItem(
                    icon: Icons.discount,
                    title: 'Special Offer',
                    message: 'Get 20% discount on your next premium payment. Offer valid till end of month.',
                    time: '1 week ago',
                    isUnread: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isUnread ? Colors.blue.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUnread ? Colors.blue.shade200 : Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isUnread ? Colors.blue.shade100 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isUnread ? Colors.blue.shade700 : Colors.grey.shade700,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* ================= HELP SECTION ================= */

  Widget _buildHelpSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF1E3A8A), // Blue
            Color(0xFF7C3AED), // Purple
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Heading
          Text(
            'Need Help Choosing?',
            style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Subheading
          Text(
            'Our insurance experts are here to guide you through your options',
            style: GoogleFonts.inter(
              fontSize: 17,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Buttons
          if (isSmallScreen) ...[
            // Column layout for small screens
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHelpButton(
                  text: 'Schedule Consultation',
                  isPrimary: true,
                ),
                const SizedBox(height: 16),
                _buildHelpButton(
                  text: 'Chat with Expert',
                  isPrimary: false,
                ),
              ],
            ),
          ] else ...[
            // Row layout for larger screens
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHelpButton(
                  text: 'Schedule Consultation',
                  isPrimary: true,
                ),
                const SizedBox(width: 20),
                _buildHelpButton(
                  text: 'Chat with Expert',
                  isPrimary: false,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHelpButton({
    required String text,
    required bool isPrimary,
  }) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.white : Colors.transparent,
        foregroundColor: isPrimary ? const Color(0xFF1E3A8A) : Colors.white,
        side: isPrimary ? null : const BorderSide(color: Colors.white, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Pill-shaped
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        elevation: isPrimary ? 4 : 0,
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /* ================= CURRENT PAGE CONTENT ================= */

  Widget _buildCurrentPageContent() {
    switch (_currentPage) {
      case DashboardPageType.dashboard:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Welcome + Stats on left, Quick Actions on right
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: Welcome and Stats
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Card
                      _buildWelcomeCard(),
                      const SizedBox(height: 32),

                      // Stats Cards
                      _buildStatsCards(),
                    ],
                  ),
                ),
                const SizedBox(width: 32),

                // Right side: Quick Actions
                Expanded(
                  flex: 1,
                  child: _buildQuickActionsCard(),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Recommendations Section
            _buildRecommendationsSection(),
          ],
        );
      default:
        return const Center(child: Text('Page not found'));
    }
  }


}
