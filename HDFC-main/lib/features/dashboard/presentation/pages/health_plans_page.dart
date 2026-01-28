import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';

class HealthPlansPage extends StatefulWidget {
  const HealthPlansPage({super.key});

  @override
  State<HealthPlansPage> createState() => _HealthPlansPageState();
}

class _HealthPlansPageState extends State<HealthPlansPage> {
  void _onSidebarItemTap(String item) {
    // Handle navigation based on the selected item
    switch (item) {
      case 'Dashboard':
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => DashboardPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Health Plans':
        // Already on this page
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
      case 'Life Insurance':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const LifeInsurancePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Home Insurance':
        // Handle navigation
        break;
      case 'Auto Insurance':
        // Handle navigation
        break;
      case 'Get Help':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const GetHelpPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Settings':
        // Handle settings
        break;
      case 'Profile':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const ProfilePage(),
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
          Container(
            color: Colors.grey.shade50,
            child: Row(
              children: [
                if (isDesktop) ...[
                  /// LEFT SIDEBAR - Full Height (Desktop only)
                  SidebarWidget(
                    activeItem: 'Health Plans',
                    onItemTap: _onSidebarItemTap,
                  ),
                ],

                /// MAIN CONTENT AREA
                Expanded(
                  child: Column(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Page Header
                                  Text(
                                    'Health Insurance Plans',
                                    style: GoogleFonts.inter(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Comprehensive health coverage for you and your family',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 32),

                                  // Health Plans Grid
                                  GridView.count(
                                    crossAxisCount: screenWidth < 600 ? 1 : (screenWidth < 1000 ? 2 : 3),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    crossAxisSpacing: 24,
                                    mainAxisSpacing: 24,
                                    childAspectRatio: 0.8,
                                    children: [
                                      _buildHealthPlanCard(
                                        title: 'Smart Health Plus',
                                        price: '₹2,499/month',
                                        coverage: '₹5,00,000',
                                        features: [
                                          'Hospitalization coverage',
                                          'Dental & vision care',
                                          'Mental health support',
                                          '24/7 doctor consultation',
                                        ],
                                        isPopular: true,
                                      ),
                                      _buildHealthPlanCard(
                                        title: 'Family Health Shield',
                                        price: '₹3,999/month',
                                        coverage: '₹10,00,000',
                                        features: [
                                          'Complete family coverage',
                                          'Maternity benefits',
                                          'Critical illness cover',
                                          'Annual health checkup',
                                        ],
                                        isPopular: false,
                                      ),
                                      _buildHealthPlanCard(
                                        title: 'Senior Care Plus',
                                        price: '₹4,499/month',
                                        coverage: '₹7,50,000',
                                        features: [
                                          'Senior citizen friendly',
                                          'Pre-existing conditions',
                                          'Home healthcare',
                                          'Emergency ambulance',
                                        ],
                                        isPopular: false,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
        ],
      ),
      drawer: isDesktop ? null : SidebarWidget(
        activeItem: 'Health Plans',
        onItemTap: _onSidebarItemTap,
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, {required bool isDesktop}) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      leading: isDesktop ? null : Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Container(
        width: isDesktop ? 400 : 280,
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
                decoration: InputDecoration(
                  hintText: isDesktop ? 'Search health plans...' : 'Search...',
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
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black87, size: 24),
          onPressed: () {},
          tooltip: 'Notifications',
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person, color: Colors.black87, size: 20),
          label: Text(
            'My Profile',
            style: GoogleFonts.inter(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.logout, color: Colors.red.shade700, size: 20),
          onPressed: () {},
          tooltip: 'Logout',
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildHealthPlanCard({
    required String title,
    required String price,
    required String coverage,
    required List<String> features,
    required bool isPopular,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPopular ? AppColors.primary.withOpacity(0.3) : Colors.grey.shade200,
          width: isPopular ? 2 : 1,
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
          // Header with Popular Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.health_and_safety,
                  color: Colors.green,
                  size: 24,
                ),
              ),
              if (isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Most Popular',
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

          // Title
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Coverage
          Text(
            'Coverage: $coverage',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),

          // Price
          Text(
            price,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          // Features
          Column(
            children: features.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
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
          const Spacer(),

          // CTA Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isPopular ? AppColors.primary : Colors.grey[100],
                foregroundColor: isPopular ? Colors.white : Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
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
    );
  }
}
