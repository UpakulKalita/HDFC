import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/profile_hero.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/premium_card.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/modern_field.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/modern_dropdown.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/counter_field.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/profile_strength_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // --- FORM CONTROLLERS ---
  final _nameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  final _phoneController = TextEditingController(text: '+91 9876543210');
  
  // --- INSURANCE FIELDS ---
  String _maritalStatus = 'Single';
  String _tobacco = 'No';
  String _income = '₹10L - ₹15L';
  String _occupation = 'Software Engineer';
  int _children = 0;
  int _dependentParents = 2;

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
      case 'Profile':
        break;
    }
  }

  double _calculateCompletion() {
    int total = 9;
    int filled = 0;
    if (_nameController.text.isNotEmpty) filled++;
    if (_emailController.text.isNotEmpty) filled++;
    if (_phoneController.text.isNotEmpty) filled++;
    if (_maritalStatus.isNotEmpty) filled++;
    if (_tobacco.isNotEmpty) filled++;
    if (_income.isNotEmpty) filled++;
    if (_occupation.isNotEmpty) filled++;
    if (_children >= 0) filled++;
    if (_dependentParents >= 0) filled++;
    return filled / total;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;
    final completion = _calculateCompletion();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        children: [
          if (isDesktop) SidebarWidget(activeItem: 'Profile', onItemTap: _onSidebarItemTap),
          Expanded(
            child: CustomScrollView(
              slivers: [
                // --- PREMIUM HERO HEADER ---
                SliverToBoxAdapter(
                  child: ProfileHero(
                    completion: completion,
                    isDesktop: isDesktop,
                    onBackTap: () => Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, _, _) => const DashboardPage(), transitionDuration: Duration.zero)),
                    onSaveTap: () {},
                  ),
                ),

                // --- MAIN CONTENT GRID ---
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 64 : 20,
                    vertical: 32,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Wrap(
                              spacing: 24,
                              runSpacing: 24,
                              children: [
                                // Bento Card 1: Account Info
                                PremiumCard(
                                  title: 'Account Information',
                                  icon: LucideIcons.user,
                                  width: isDesktop ? (constraints.maxWidth - 24) * 0.6 : constraints.maxWidth,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            ModernField(label: 'Full Name', controller: _nameController, icon: LucideIcons.user),
                                            ModernField(label: 'Email Address', controller: _emailController, icon: LucideIcons.mail),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            ModernField(label: 'Phone Number', controller: _phoneController, icon: LucideIcons.phone),
                                            ModernField(label: 'Date of Birth', controller: TextEditingController(text: '12 May 1995'), icon: LucideIcons.calendar),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.1),

                                // Bento Card 2: Profile Strength
                                PremiumCard(
                                  title: 'Profile Status',
                                  titleColor: AppColors.primary,
                                  icon: LucideIcons.activity,
                                  width: isDesktop ? (constraints.maxWidth - 24) * 0.4 - 1 : constraints.maxWidth,
                                  child: Column(
                                    children: [
                                      ProfileStrengthIndicator(completion: completion),
                                      const SizedBox(height: 24),
                                      _buildStatusItem(LucideIcons.shieldCheck, 'Verified Account', Colors.green),
                                      _buildStatusItem(LucideIcons.zap, 'Instant Matching On', Colors.orange),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideY(begin: 0.1),

                                // Bento Card 3: Lifestyle & Insurance
                                PremiumCard(
                                  title: 'Insurance Profile',
                                  icon: LucideIcons.shieldCheck,
                                  width: isDesktop ? (constraints.maxWidth - 24) * 0.5 : constraints.maxWidth,
                                  child: Column(
                                    children: [
                                      ModernDropdown(label: 'Marital Status', value: _maritalStatus, items: const ['Single', 'Married', 'Divorced', 'Widowed'], onChanged: (val) => setState(() => _maritalStatus = val!)),
                                      ModernDropdown(label: 'Tobacco / Smoking', value: _tobacco, items: const ['No', 'Yes', 'Occasional'], onChanged: (val) => setState(() => _tobacco = val!)),
                                      ModernField(label: 'Occupation', controller: TextEditingController(text: _occupation), icon: LucideIcons.briefcase, onChanged: (val) => _occupation = val),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.1),

                                // Bento Card 4: Dependents & Family
                                PremiumCard(
                                  title: 'Family & Dependents',
                                  icon: LucideIcons.users,
                                  width: isDesktop ? (constraints.maxWidth - 24) * 0.5 - 1 : constraints.maxWidth,
                                  child: Column(
                                    children: [
                                      CounterField(label: 'Number of Children', value: _children, onChanged: (val) => setState(() => _children = val)),
                                      const SizedBox(height: 20),
                                      CounterField(label: 'Dependent Parents', value: _dependentParents, onChanged: (val) => setState(() => _dependentParents = val)),
                                      const SizedBox(height: 20),
                                      ModernDropdown(label: 'Annual Income', value: _income, items: const ['< ₹5L', '₹5L - ₹10L', '₹10L - ₹15L', '₹15L+'], onChanged: (val) => setState(() => _income = val!)),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 600.ms, delay: 700.ms).slideY(begin: 0.1),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: isDesktop ? null : SidebarWidget(activeItem: 'Profile', onItemTap: _onSidebarItemTap),
    );
  }

  Widget _buildStatusItem(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}
