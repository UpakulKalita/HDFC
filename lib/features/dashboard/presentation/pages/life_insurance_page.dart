import 'package:flutter/material.dart';


import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/plan_page_header.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/auto_plan_card.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/my_policies_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:insurance_flutter/core/services/json_service.dart';
import 'package:insurance_flutter/features/dashboard/data/models/insurance_plan_model.dart';


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
      case 'My Profile':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const ProfilePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'My Policies':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MyPoliciesPage(),
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

                                return FutureBuilder<List<AutoPlan>>(
                                  future: JsonService.loadAutoPlans(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    if (snapshot.hasError) {
                                      return Center(child: Text('Error: ${snapshot.error}'));
                                    }
                                    final plans = snapshot.data ?? [];
                                    return Wrap(
                                      spacing: spacing,
                                      runSpacing: 24,
                                      children: plans.asMap().entries.map((entry) {
                                        final index = entry.key;
                                        final plan = entry.value;
                                        return SizedBox(
                                          width: cardWidth,
                                          child: AutoPlanCard(
                                            plan: plan,
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

}
