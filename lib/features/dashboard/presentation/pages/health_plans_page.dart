import 'package:flutter/material.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/plan_page_header.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/health_plan_card.dart';
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
                activeItem: 'Health Plans',
                onItemTap: _onSidebarItemTap,
              ),
            Expanded(
              child: Column(
                children: [
                  PlanPageHeader(
                    title: 'Health Insurance Plans',
                    subtitle: 'Comprehensive health coverage for you and your family',
                    searchHint: isDesktop ? 'Search health plans...' : 'Search...',
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
        activeItem: 'Health Plans',
        onItemTap: _onSidebarItemTap,
      ),
    );
  }

  List<_PlanData> _getMockPlans() {
    return [
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
