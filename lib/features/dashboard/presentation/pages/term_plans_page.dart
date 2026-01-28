import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/settings_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TermPlansPage extends StatefulWidget {
  const TermPlansPage({super.key});

  @override
  State<TermPlansPage> createState() => _TermPlansPageState();
}

class _TermPlansPageState extends State<TermPlansPage> {
  void _onSidebarItemTap(String item) {
    // Handle navigation based on the selected item
    switch (item) {
      case 'Dashboard':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => DashboardPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Health Plans':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const HealthPlansPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Term Life Plans':
        // Already on this page
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
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const SettingsPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
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
                    activeItem: 'Term Life Plans',
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
                                        'Term Life Insurance Plans',
                                        style: GoogleFonts.inter(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Secure your family\'s future with comprehensive term life coverage',
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
                                      // 1. Click 2 Protect Super (Popular)
                                      _PlanData(
                                        title: 'Click 2 Protect Super',
                                        imageUrl: 'https://images.unsplash.com/photo-1543269865-cbf427effbad?auto=format&fit=crop&q=80&w=600',
                                        price: '₹950/mo',
                                        coverage: '₹1 Crore',
                                        claimRatio: '99.3%',
                                        term: '40 Yrs',
                                        waitingPeriod: 'Instant',
                                        features: [
                                          'Pure term protection plan.',
                                          'Accidental death benefit rider.',
                                          'Terminal illness cover built-in.',
                                          'Waiver of premium on disability.',
                                        ],
                                        tags: ['Best Seller', 'High Cover'],
                                        isPopular: true,
                                      ),
                                      // 2. Life Shield Plus
                                      _PlanData(
                                        title: 'Life Shield Plus',
                                        imageUrl: 'https://images.unsplash.com/photo-1516733968668-dbdce39c4651?auto=format&fit=crop&q=80&w=600',
                                        price: '₹1,250/mo',
                                        coverage: '₹2 Crores',
                                        claimRatio: '98.9%',
                                        term: '50 Yrs',
                                        waitingPeriod: '7 Days',
                                        features: [
                                          'Extended coverage till 99 years.',
                                          'Return of premium option.',
                                          'Critical illness protection.',
                                          'Flexible payout options.',
                                        ],
                                        tags: ['Whole Life', 'Premium Return'],
                                        isPopular: false,
                                      ),
                                      // 3. Saral Jeevan Bima
                                      _PlanData(
                                        title: 'Saral Jeevan Bima',
                                        imageUrl: 'https://images.unsplash.com/photo-1556742502-ec7c0e9f34b1?auto=format&fit=crop&q=80&w=600',
                                        price: '₹450/mo',
                                        coverage: '₹25 Lakhs',
                                        claimRatio: '97.5%',
                                        term: '20 Yrs',
                                        waitingPeriod: '30 Days',
                                        features: [
                                          'Standard term life insurance.',
                                          'Simplified underwriting process.',
                                          'No medical check-up required.',
                                          'Affordable premiums for all.',
                                        ],
                                        tags: ['Standard', 'Govt Regulated'],
                                        isPopular: false,
                                      ),
                                      // 4. Income Replacement Term
                                      _PlanData(
                                        title: 'Income Replacement Term',
                                        imageUrl: 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?auto=format&fit=crop&q=80&w=600',
                                        price: '₹1,100/mo',
                                        coverage: '₹1Cr + Income',
                                        claimRatio: '98.5%',
                                        term: '30 Yrs',
                                        waitingPeriod: 'Instant',
                                        features: [
                                          'Lump sum plus monthly income.',
                                          'Ensures family lifestyle continuity.',
                                          'Inflation adjusted payouts.',
                                          'Tax benefits under 80C/10(10D).',
                                        ],
                                        tags: ['Income Benefit', 'Family Secure'],
                                        isPopular: false,
                                      ),
                                      // 5. Smart Term Pro
                                      _PlanData(
                                        title: 'Smart Term Pro',
                                        imageUrl: 'https://images.unsplash.com/photo-1560520653-9e0e4c89eb11?auto=format&fit=crop&q=80&w=600',
                                        price: '₹600/mo',
                                        coverage: '₹50 Lakhs',
                                        claimRatio: '99.0%',
                                        term: '25 Yrs',
                                        waitingPeriod: '15 Days',
                                        features: [
                                          'Smart exit option available.',
                                          'Increase cover at life stages.',
                                          'Spouse cover add-on.',
                                          'Special rates for women.',
                                        ],
                                        tags: ['Flexible', 'Smart Exit'],
                                        isPopular: false,
                                      ),
                                      // 6. Family Protector Plan
                                      _PlanData(
                                        title: 'Family Protector Plan',
                                        imageUrl: 'https://images.unsplash.com/photo-1558008258-3256797b43f3?auto=format&fit=crop&q=80&w=600',
                                        price: '₹1,500/mo',
                                        coverage: '₹1.5 Crores',
                                        claimRatio: '98.0%',
                                        term: '35 Yrs',
                                        waitingPeriod: 'Instant',
                                        features: [
                                          'Joint life cover for spouses.',
                                          'Discount on joint applications.',
                                          'Child education fund security.',
                                          'Comprehensive rider suite.',
                                        ],
                                        tags: ['Joint Life', 'Spouse Cover'],
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
                                          child: TermPlanCard(
                                            title: plan.title,
                                            imageUrl: plan.imageUrl,
                                            price: plan.price,
                                            coverage: plan.coverage,
                                            claimRatio: plan.claimRatio,
                                            term: plan.term,
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
        activeItem: 'Term Life Plans',
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
                  hintText: isDesktop ? 'Search term plans...' : 'Search...',
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
  final String term;
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
    required this.term,
    required this.waitingPeriod,
    required this.features,
    required this.tags,
    required this.isPopular,
  });
}

class TermPlanCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String coverage;
  final String claimRatio;
  final String term;
  final String waitingPeriod;
  final List<String> features;
  final List<String> tags;
  final bool isPopular;

  const TermPlanCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.coverage,
    required this.claimRatio,
    required this.term,
    required this.waitingPeriod,
    required this.features,
    required this.tags,
    required this.isPopular,
  });

  @override
  State<TermPlanCard> createState() => _TermPlanCardState();
}

class _TermPlanCardState extends State<TermPlanCard> with AutomaticKeepAliveClientMixin {
  bool _isHovered = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Theme Color for Term Plans (Blue)
    const primaryColor = Color(0xFF1565C0); // Blue 800

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
                ? primaryColor.withOpacity(0.5)
                : (_isHovered ? primaryColor.withOpacity(0.3) : Colors.grey.shade200),
            width: widget.isPopular ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isPopular
                  ? primaryColor.withOpacity(_isHovered ? 0.2 : 0.1)
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
                          colors: [const Color(0xFF1E88E5), const Color(0xFF1565C0)],
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
                      Expanded(child: _buildStatTile('Coverage', widget.coverage, Icons.shield_outlined, primaryColor)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatTile('Term', widget.term, LucideIcons.calendar, primaryColor)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatTile('Claims', widget.claimRatio, Icons.verified_user_outlined, primaryColor)),
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
                              color: primaryColor.withOpacity(0.6),
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
                        backgroundColor: widget.isPopular ? primaryColor : Colors.black,
                        foregroundColor: Colors.white,
                        elevation: widget.isPopular ? 8 : 0,
                        shadowColor: widget.isPopular ? primaryColor.withOpacity(0.4) : null,
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
