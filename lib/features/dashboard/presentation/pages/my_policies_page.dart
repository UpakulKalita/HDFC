import 'package:flutter/material.dart';

import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/policy_card.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/policies_hero.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MyPoliciesPage extends StatefulWidget {
  const MyPoliciesPage({super.key});

  @override
  State<MyPoliciesPage> createState() => _MyPoliciesPageState();
}

class _MyPoliciesPageState extends State<MyPoliciesPage> {
  void _onSidebarItemTap(String item) {
    switch (item) {
      case 'Dashboard':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, _, _) => DashboardPage(), transitionDuration: Duration.zero));
        break;
      case 'Health Plans':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, _, _) => const HealthPlansPage(), transitionDuration: Duration.zero));
        break;
      case 'Term Life Plans':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, _, _) => const TermPlansPage(), transitionDuration: Duration.zero));
        break;
      case 'Auto Insurance':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, _, _) => const LifeInsurancePage(), transitionDuration: Duration.zero));
        break;
      case 'Get Help':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, _, _) => const GetHelpPage(), transitionDuration: Duration.zero));
        break;
      case 'My Profile':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, _, _) => const ProfilePage(), transitionDuration: Duration.zero));
        break;
      case 'My Policies':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          if (isDesktop) SidebarWidget(activeItem: 'Dashboard', onItemTap: _onSidebarItemTap),
          Expanded(
            child: CustomScrollView(
              slivers: [
                // --- HERO SECTION ---
                SliverToBoxAdapter(
                  child: PoliciesHero(
                    isDesktop: isDesktop,
                    onBackTap: () => Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, _, _) => const DashboardPage(), transitionDuration: Duration.zero)),
                  ),
                ),

                // --- POLICIES LIST ---
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(isDesktop ? 64 : 24, 40, isDesktop ? 64 : 24, 64),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const PolicyCard(
                        type: 'Health Insurance',
                        policyName: 'Family Floater Ultimate',
                        policyNumber: 'HDFC-HL-2024-8891',
                        status: 'Active',
                        premium: '₹12,400',
                        nextDue: '15 Mar 2025',
                        icon: Icons.health_and_safety,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 20),
                      const PolicyCard(
                        type: 'Auto Insurance',
                        policyName: 'Elite Car Protect',
                        policyNumber: 'HDFC-AU-2023-4412',
                        status: 'Active',
                        premium: '₹4,200',
                        nextDue: '20 Jul 2025',
                        icon: LucideIcons.car,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 20),
                      PolicyCard(
                        type: 'Term Life',
                        policyName: 'Secure Life Plan',
                        policyNumber: 'HDFC-LF-2022-1104',
                        status: 'Active',
                        premium: '₹8,500',
                        nextDue: '10 Jan 2026',
                        icon: Icons.shield_rounded,
                        color: Colors.amber.shade700,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

