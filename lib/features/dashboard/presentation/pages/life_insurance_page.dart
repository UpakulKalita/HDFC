import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/settings_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LifeInsurancePage extends StatefulWidget {
  const LifeInsurancePage({super.key});

  @override
  State<LifeInsurancePage> createState() => _LifeInsurancePageState();
}

class _LifeInsurancePageState extends State<LifeInsurancePage> {
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
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const TermPlansPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Auto Insurance':
        // Already on this page
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
                    activeItem: 'Auto Insurance',
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
                                        'Auto Insurance Plans',
                                        style: GoogleFonts.inter(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Comprehensive vehicle protection with 24/7 roadside assistance',
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
                                      // 1. Elite Car Protect (Popular)
                                      _PlanData(
                                        title: 'Elite Car Protect',
                                        imageUrl: 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?auto=format&fit=crop&q=80&w=600',
                                        price: '₹1,200/mo',
                                         idv: '100%',
                                        ncb: 'Up to 50%',
                                        garages: '1500+',
                                        features: [
                                          'Zero depreciation cover included.',
                                          'Engine and gearbox protection.',
                                          'Consumables cover provided.',
                                          'Return to invoice benefit.',
                                        ],
                                        tags: ['Comprehensive', 'Recommended'],
                                        isPopular: true,
                                      ),
                                      // 2. SUV Adventure Shield
                                      _PlanData(
                                        title: 'SUV Adventure Shield',
                                        imageUrl: 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=600',
                                        price: '₹1,550/mo',
                                         idv: 'High IDV',
                                        ncb: 'NCB Retention',
                                        garages: '1200+',
                                        features: [
                                          'Specialized off-road protection.',
                                          'Tyre and rim cover included.',
                                          'Key replacement assistance.',
                                          'Personal accident cover extra.',
                                        ],
                                        tags: ['SUV Special', 'Off-road'],
                                        isPopular: false,
                                      ),
                                      // 3. Compact Sedan Saver
                                      _PlanData(
                                        title: 'Compact Sedan Saver',
                                        imageUrl: 'https://images.unsplash.com/photo-1541899481282-d53bffe3c35d?auto=format&fit=crop&q=80&w=600',
                                        price: '₹750/mo',
                                         idv: 'Standard',
                                        ncb: 'Step-up NCB',
                                        garages: '1000+',
                                        features: [
                                          'Basic third-party liability.',
                                          'Collision damage protection.',
                                          'Theft and fire coverage.',
                                          'Free roadside assistance.',
                                        ],
                                        tags: ['Budget Friendly', 'Essential'],
                                        isPopular: false,
                                      ),
                                      // 4. Luxury Vehicle Pro
                                      _PlanData(
                                        title: 'Luxury Vehicle Pro',
                                        imageUrl: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&q=80&w=600',
                                        price: '₹4,500/mo',
                                         idv: 'Agreed Val',
                                        ncb: 'No-Claim Protect',
                                        garages: 'Exclusive Network',
                                        features: [
                                          'Unlimited zero-dep claims.',
                                          'Luxury car specialized repair.',
                                          'Global roadside assistance.',
                                          'Concierge claim service.',
                                        ],
                                        tags: ['Premium', 'Luxury'],
                                        isPopular: false,
                                      ),
                                      // 5. Electric Spark Protect
                                      _PlanData(
                                        title: 'Electric Spark Protect',
                                        imageUrl: 'https://images.unsplash.com/photo-1593941707882-a5bba14938c7?auto=format&fit=crop&q=80&w=600',
                                        price: '₹999/mo',
                                         idv: 'Battery Max',
                                        ncb: 'Eco Bonus',
                                        garages: 'EV Specialized',
                                        features: [
                                          'Battery and motor protection.',
                                          'Charging cable theft cover.',
                                          'On-road charging support.',
                                          'Low emission discounts.',
                                        ],
                                        tags: ['EV Special', 'Eco-Friendly'],
                                        isPopular: false,
                                      ),
                                      // 6. Basic Third Party
                                      _PlanData(
                                        title: 'Basic Third Party',
                                        imageUrl: 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?auto=format&fit=crop&q=80&w=600',
                                        price: '₹450/mo',
                                         idv: 'Statutory',
                                        ncb: 'N/A',
                                        garages: 'Network Only',
                                        features: [
                                          'Legal liability to third party.',
                                          'Property damage protection.',
                                          'Compliance with law focus.',
                                          'Personal accident add-on.',
                                        ],
                                        tags: ['Essential', 'Compliance'],
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
                                          child: AutoPlanCard(
                                            title: plan.title,
                                            imageUrl: plan.imageUrl,
                                            price: plan.price,
                                            idv: plan.idv,
                                            ncb: plan.ncb,
                                            garages: plan.garages,
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
        activeItem: 'Auto Insurance',
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
                  hintText: isDesktop ? 'Search auto plans...' : 'Search...',
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
  final String idv;
  final String ncb;
  final String garages;
  final List<String> features;
  final List<String> tags;
  final bool isPopular;

  _PlanData({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.idv,
    required this.ncb,
    required this.garages,
    required this.features,
    required this.tags,
    required this.isPopular,
  });
}

class AutoPlanCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String idv;
  final String ncb;
  final String garages;
  final List<String> features;
  final List<String> tags;
  final bool isPopular;

  const AutoPlanCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.idv,
    required this.ncb,
    required this.garages,
    required this.features,
    required this.tags,
    required this.isPopular,
  });

  @override
  State<AutoPlanCard> createState() => _AutoPlanCardState();
}

class _AutoPlanCardState extends State<AutoPlanCard> with AutomaticKeepAliveClientMixin {
  bool _isHovered = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Theme Color for Auto Insurance (Red)
    const primaryColor = Color(0xFFD32F2F); // Red 700

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
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
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
                          const Icon(Icons.local_fire_department, color: Colors.white, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            'Hot Recommend',
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
                      Expanded(child: _buildStatTile('Value', widget.idv, LucideIcons.car, primaryColor)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatTile('NCB', widget.ncb, Icons.percent, primaryColor)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatTile('Garages', widget.garages, Icons.settings_suggest_outlined, primaryColor)),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),

                  // Why Recommended
                  Text(
                    'Coverage Perks',
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
                              'billed monthly',
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
          ),
        ],
      ),
    );
  }
}
