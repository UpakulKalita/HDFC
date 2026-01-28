import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      case 'Term Life Plans':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => TermPlansPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Auto Insurance':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const LifeInsurancePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
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
                        child: CustomScrollView(
                          cacheExtent: 0,
                          slivers: [
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(32, 32, 32, 24),
                                child: Container(
                                  constraints: const BoxConstraints(maxWidth: 1400),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                              sliver: SliverToBoxAdapter(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final double screenWidth = MediaQuery.of(context).size.width;
                                    int crossAxisCount = screenWidth < 600 ? 1 : (screenWidth < 1100 ? 2 : 3);
                                    double spacing = 24.0;
                                    double availableWidth = constraints.maxWidth;
                                    double cardWidth = (availableWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;

                                    if (crossAxisCount == 1) {
                                       cardWidth = availableWidth;
                                    }

                                    final plans = [
                                      // 1. Smart Health Plus
                                      _PlanData(
                                        title: 'Smart Health Plus',
                                        imageUrl: 'https://images.unsplash.com/photo-1544027993-37dbfe43562a?auto=format&fit=crop&q=80&w=600',
                                        price: '₹2,499/mo',
                                        coverage: '₹5 Lakhs',
                                        claimRatio: '98.5%',
                                        hospitals: '10k+',
                                        waitingPeriod: '2 Yrs',
                                        features: [
                                          'Covers 100% of hospitalization expenses.',
                                          'Includes dental and vision care treatments.',
                                          'Full support for mental well-being.',
                                          'Access to doctors 24/7 anytime.',
                                        ],
                                        tags: ['Tax Saver', 'No Medical Test'],
                                        isPopular: true,
                                      ),
                                      // 2. Family Health Shield
                                      _PlanData(
                                        title: 'Family Health Shield',
                                        imageUrl: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&q=80&w=600',
                                        price: '₹3,999/mo',
                                        coverage: '₹10 Lakhs',
                                        claimRatio: '99.2%',
                                        hospitals: '12k+',
                                        waitingPeriod: '1 Yr',
                                        features: [
                                          'Complete protection for your entire family.',
                                          'Coverage for all maternity related expenses.',
                                          'Critical illness protection included.',
                                          'Annual free health checkup for all.',
                                        ],
                                        tags: ['Best Seller', 'Maternity'],
                                        isPopular: false,
                                      ),
                                      // 3. Senior Care Plus
                                      _PlanData(
                                        title: 'Senior Care Plus',
                                        imageUrl: 'https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?auto=format&fit=crop&q=80&w=600',
                                        price: '₹4,499/mo',
                                        coverage: '₹7.5 Lakhs',
                                        claimRatio: '97.8%',
                                        hospitals: '8k+',
                                        waitingPeriod: '3 Yrs',
                                        features: [
                                          'Specialized care designed for seniors.',
                                          'Covers pre-existing diseases from day 1.',
                                          'Home healthcare services included.',
                                          'Emergency ambulance costs covered.',
                                        ],
                                        tags: ['Senior Special', 'AYUSH'],
                                        isPopular: false,
                                      ),
                                      // 4. Critical Illness Cover
                                      _PlanData(
                                        title: 'Critical Illness Cover',
                                        imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&q=80&w=600',
                                        price: '₹1,299/mo',
                                        coverage: '₹20 Lakhs',
                                        claimRatio: '99.0%',
                                        hospitals: '15k+',
                                        waitingPeriod: '90 Days',
                                        features: [
                                          'Lump sum payout on diagnosis.',
                                          'Covers 30+ critical illnesses.',
                                          'Income replacement benefit included.',
                                          'Second medical opinion service.',
                                        ],
                                        tags: ['High Cover', 'Lump Sum'],
                                        isPopular: false,
                                      ),
                                      // 5. Young Star Policy
                                      _PlanData(
                                        title: 'Young Star Policy',
                                        imageUrl: 'https://images.unsplash.com/photo-1529333166437-7750a6dd5a70?auto=format&fit=crop&q=80&w=600',
                                        price: '₹999/mo',
                                        coverage: '₹3 Lakhs',
                                        claimRatio: '98.2%',
                                        hospitals: '9k+',
                                        waitingPeriod: '1 Yr',
                                        features: [
                                          'Low premium for young adults.',
                                          'Automatic restoration of sum insured.',
                                          'Road ambulance charges covered.',
                                          'Wellness program rewards included.',
                                        ],
                                        tags: ['Youth Special', 'Low Cost'],
                                        isPopular: false,
                                      ),
                                      // 6. Diabetes Safe Plan
                                      _PlanData(
                                        title: 'Diabetes Safe Plan',
                                        imageUrl: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?auto=format&fit=crop&q=80&w=600',
                                        price: '₹2,999/mo',
                                        coverage: '₹5 Lakhs',
                                        claimRatio: '97.5%',
                                        hospitals: '8.5k+',
                                        waitingPeriod: 'Day 1',
                                        features: [
                                          'Diabetes coverage from Day 1.',
                                          'Regular health monitoring support.',
                                          'Diet and nutrition counseling.',
                                          'Dialysis expenses covered.',
                                        ],
                                        tags: ['Disease Specific', 'Day 1 Cover'],
                                        isPopular: false,
                                      ),
                                      // 7. Women Care Policy
                                      _PlanData(
                                        title: 'Women Care Policy',
                                        imageUrl: 'https://images.unsplash.com/photo-1590650516494-0c8e4a4dd67e?auto=format&fit=crop&q=80&w=600',
                                        price: '₹1,899/mo',
                                        coverage: '₹10 Lakhs',
                                        claimRatio: '98.7%',
                                        hospitals: '11k+',
                                        waitingPeriod: '2 Yrs',
                                        features: [
                                          'Comprehensive coverage for women.',
                                          'Maternity and newborn cover.',
                                          'Cancer screening checkups.',
                                          'Wellness and fitness programs.',
                                        ],
                                        tags: ['Women Special', 'Wellness'],
                                        isPopular: false,
                                      ),
                                      // 8. Super Top Up Plan
                                      _PlanData(
                                        title: 'Super Top Up Plan',
                                        imageUrl: 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&q=80&w=600',
                                        price: '₹599/mo',
                                        coverage: '₹25 Lakhs',
                                        claimRatio: '99.5%',
                                        hospitals: '14k+',
                                        waitingPeriod: 'Nil',
                                        features: [
                                          'Enhance your existing coverage.',
                                          'High deductible options available.',
                                          'No pre-policy medical checkup.',
                                          'Covers expenses above threshold.',
                                        ],
                                        tags: ['Booster', 'High Cover'],
                                        isPopular: false,
                                      ),
                                      // 9. Arogya Sanjeevani
                                      _PlanData(
                                        title: 'Arogya Sanjeevani',
                                        imageUrl: 'https://images.unsplash.com/photo-1504813184591-01572f98c85f?auto=format&fit=crop&q=80&w=600',
                                        price: '₹1,499/mo',
                                        coverage: '₹5 Lakhs',
                                        claimRatio: '98.0%',
                                        hospitals: '10k+',
                                        waitingPeriod: '4 Yrs',
                                        features: [
                                          'Standard health insurance product.',
                                          'Cumulative bonus on claim-free years.',
                                          'Cataract treatment limit defined.',
                                          'AYUSH treatment expenses covered.',
                                        ],
                                        tags: ['Standard', 'Govt Regulated'],
                                        isPopular: false,
                                      ),
                                    ];

                                    return Wrap(
                                      spacing: spacing,
                                      runSpacing: 24,
                                      children: plans.asMap().entries.map((entry) {
                                        final index = entry.key;
                                        final plan = entry.value;
                                        return SizedBox(
                                          width: cardWidth,
                                          child: HealthPlanCard(
                                            title: plan.title,
                                            imageUrl: plan.imageUrl,
                                            price: plan.price,
                                            coverage: plan.coverage,
                                            claimRatio: plan.claimRatio,
                                            hospitals: plan.hospitals,
                                            waitingPeriod: plan.waitingPeriod,
                                            features: plan.features,
                                            tags: plan.tags,
                                            isPopular: plan.isPopular,
                                          )
                                          .animate()
                                          .fadeIn(duration: 1200.ms, delay: (200 + (index % 3 * 400)).ms)
                                          .slideY(begin: 0.2, end: 0, duration: 1000.ms, curve: Curves.easeOutCubic),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
                          ],
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
      toolbarHeight: 80,
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
}

class _PlanData {
  final String title;
  final String imageUrl;
  final String price;
  final String coverage;
  final String claimRatio;
  final String hospitals;
  final String waitingPeriod;
  final List<String> features;
  final List<String> tags;
  final bool isPopular;

  _PlanData({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.coverage,
    required this.claimRatio,
    required this.hospitals,
    required this.waitingPeriod,
    required this.features,
    required this.tags,
    required this.isPopular,
  });
}

class HealthPlanCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String coverage;
  final String claimRatio;
  final String hospitals;
  final String waitingPeriod;
  final List<String> features;
  final List<String> tags;
  final bool isPopular;

  const HealthPlanCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.coverage,
    required this.claimRatio,
    required this.hospitals,
    required this.waitingPeriod,
    required this.features,
    required this.tags,
    required this.isPopular,
  });

  @override
  State<HealthPlanCard> createState() => _HealthPlanCardState();
}

class _HealthPlanCardState extends State<HealthPlanCard> with AutomaticKeepAliveClientMixin {
  bool _isHovered = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: _isHovered ? Matrix4.identity().scaled(1.02) : Matrix4.identity(),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: widget.isPopular
                ? const Color(0xFF4CAF50).withOpacity(0.5)
                : (_isHovered ? const Color(0xFF4CAF50).withOpacity(0.3) : Colors.grey.shade200),
            width: widget.isPopular ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isPopular
                  ? const Color(0xFF4CAF50).withOpacity(_isHovered ? 0.2 : 0.1)
                  : Colors.black.withOpacity(_isHovered ? 0.1 : 0.06),
              blurRadius: _isHovered ? 24 : 20,
              offset: Offset(0, _isHovered ? 12 : 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === IMAGE BANNER ===
            Stack(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient Overlay
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
                // Popular Badge
                if (widget.isPopular)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [const Color(0xFF4CAF50), const Color(0xFF43A047)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            'Recommended',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
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
                  if (widget.tags.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      children: widget.tags.map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.inter(
                            color: Colors.grey.shade600,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Title
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Stats (Tiled Layout)
                  Row(
                    children: [
                      Expanded(child: _buildStatTile('Coverage', widget.coverage, Icons.shield_outlined, const Color(0xFF4CAF50))),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatTile('Claims', widget.claimRatio, Icons.verified_user_outlined, const Color(0xFF4CAF50))),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatTile('Waiting', widget.waitingPeriod, Icons.hourglass_empty_rounded, const Color(0xFF4CAF50))),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),

                  // Why Recommended
                  Text(
                    'Why Recommended',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Bullet Points
                  Column(
                    children: widget.features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),

                  const SizedBox(height: 12),

                  // Price & Button
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.price,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'billed annually',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: Colors.grey.shade500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.isPopular ? const Color(0xFF4CAF50) : Colors.black,
                        foregroundColor: Colors.white,
                        elevation: widget.isPopular ? 8 : 0,
                        shadowColor: widget.isPopular ? const Color(0xFF4CAF50).withOpacity(0.4) : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'View Plan',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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

  Widget _buildStatTile(String label, String value, IconData icon, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(10),
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
              Icon(icon, size: 12, color: primaryColor.withOpacity(0.7)),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
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
}
