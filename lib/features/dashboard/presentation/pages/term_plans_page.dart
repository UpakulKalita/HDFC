import 'package:flutter/material.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/plan_page_header.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/term_plan_card.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';


class TermPlansPage extends StatefulWidget {
  const TermPlansPage({super.key});

  @override
  State<TermPlansPage> createState() => _TermPlansPageState();
}

class _TermPlansPageState extends State<TermPlansPage> {
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
                activeItem: 'Term Life Plans',
                onItemTap: _onSidebarItemTap,
              ),
            Expanded(
              child: Column(
                children: [
                  PlanPageHeader(
                    title: 'Term Life Insurance Plans',
                    subtitle: 'Secure your family\'s future with comprehensive term life coverage',
                    searchHint: isDesktop ? 'Search term plans...' : 'Search...',
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
        activeItem: 'Term Life Plans',
        onItemTap: _onSidebarItemTap,
      ),
    );
  }

  List<_PlanData> _getMockPlans() {
    return [
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
