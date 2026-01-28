import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/faq_item.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/support_hero.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/category_selector.dart';

class GetHelpPage extends StatefulWidget {
  const GetHelpPage({super.key});

  @override
  State<GetHelpPage> createState() => _GetHelpPageState();
}

class _GetHelpPageState extends State<GetHelpPage> {
  String _selectedCategory = 'All';

  final List<Map<String, String>> _categories = [
    {'name': 'All', 'icon': 'LucideIcons.helpCircle'},
    {'name': 'Claims', 'icon': 'LucideIcons.fileText'},
    {'name': 'Policy', 'icon': 'LucideIcons.shield'},
    {'name': 'Payments', 'icon': 'LucideIcons.creditCard'},
    {'name': 'Account', 'icon': 'LucideIcons.user'},
  ];

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
        break;
      case 'Profile':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, _, _) => const ProfilePage(), transitionDuration: Duration.zero));
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
          if (isDesktop) SidebarWidget(activeItem: 'Get Help', onItemTap: _onSidebarItemTap),
          Expanded(
            child: CustomScrollView(
              slivers: [
                // --- HERO SECTION ---
                SliverToBoxAdapter(
                  child: SupportHero(
                    isDesktop: isDesktop,
                    onBackTap: () => Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, _, _) => const DashboardPage(), transitionDuration: Duration.zero)),
                  ),
                ),

                // --- CATEGORIES ---
                SliverToBoxAdapter(
                  child: CategorySelector(
                    categories: _categories,
                    selectedCategory: _selectedCategory,
                    onCategorySelected: (cat) => setState(() => _selectedCategory = cat),
                    isDesktop: isDesktop,
                  ),
                ),

                // --- FAQ SECTION ---
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(isDesktop ? 64 : 24, 40, isDesktop ? 64 : 24, 64),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Text(
                        'Frequently Asked Questions',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const FAQItem(
                        question: 'How do I download my policy document?',
                        answer: 'You can download your policy document by going to "Dashboard", selecting your active policy, and clicking the "Download PDF" button. A copy is also sent to your registered email.',
                        category: 'Policy',
                        index: 0,
                      ),
                      const FAQItem(
                        question: 'What is the claim settlement ratio?',
                        answer: 'Our claim settlement ratio for the last financial year was 98.7%. We pride ourselves on a transparent and fast claim process through our 10k+ network hospitals.',
                        category: 'Claims',
                        index: 1,
                      ),
                      const FAQItem(
                        question: 'Can I pay my premium in installments?',
                        answer: 'Yes, we offer monthly, quarterly, half-yearly, and annual payment frequencies. You can change your preference in your "Profile" or during renewal.',
                        category: 'Payments',
                        index: 2,
                      ),
                      const FAQItem(
                        question: 'How do I update my registered mobile number?',
                        answer: 'Go to your "Profile" page, click on the edit icon next to your phone number, and follow the OTP verification process to update it securely.',
                        category: 'Account',
                        index: 3,
                      ),
                      const FAQItem(
                        question: 'What is a 15-day free look period?',
                        answer: 'It is a period during which you can review the policy terms. If you are not satisfied, you can cancel the policy and get a refund of the premium paid (minus certain charges).',
                        category: 'Policy',
                        index: 4,
                      ),
                      const FAQItem(
                        question: 'How to track my claim status in real-time?',
                        answer: 'Once a claim is filed, a tracking ID is generated. You can view the live status in the "Claims" tab or through the notifications sent to your app.',
                        category: 'Claims',
                        index: 5,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: isDesktop ? null : SidebarWidget(activeItem: 'Get Help', onItemTap: _onSidebarItemTap),
    );
  }
}

