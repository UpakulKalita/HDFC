import 'package:flutter/material.dart';


import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/plan_page_header.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/auto_plan_card.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:flutter_animate/flutter_animate.dart';


class LifeInsurancePage extends StatefulWidget {
  const LifeInsurancePage({super.key});

  @override
  State<LifeInsurancePage> createState() => _LifeInsurancePageState();
}

class _LifeInsurancePageState extends State<LifeInsurancePage> {
  void _onSidebarItemTap(String item) {
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
      body: Container(
        color: Colors.grey.shade50,
        child: Row(
          children: [
            if (isDesktop)
              SidebarWidget(
                activeItem: 'Auto Insurance',
                onItemTap: _onSidebarItemTap,
              ),
            Expanded(
              child: Column(
                children: [
                  PlanPageHeader(
                    title: 'Auto Insurance Plans',
                    subtitle: 'Comprehensive vehicle protection with 24/7 roadside assistance',
                    searchHint: isDesktop ? 'Search auto plans...' : 'Search...',
                    isDesktop: isDesktop,
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                          sliver: SliverToBoxAdapter(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final double sw = MediaQuery.of(context).size.width;
                                int crossAxisCount = sw < 600 ? 1 : (sw < 1100 ? 2 : 3);
                                double spacing = 24.0;
                                double cardWidth = (constraints.maxWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;

                                final plans = _getMockPlans();

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
                                      .fadeIn(duration: 400.ms, delay: (100 + (index % 3 * 100)).ms)
                                      .slideY(begin: 0.2, end: 0, duration: 300.ms, curve: Curves.easeOutCubic),

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
      drawer: isDesktop ? null : SidebarWidget(
        activeItem: 'Auto Insurance',
        onItemTap: _onSidebarItemTap,
      ),
    );
  }

  List<_PlanData> _getMockPlans() {
    return [
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
