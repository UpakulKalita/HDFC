import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GetHelpPage extends StatefulWidget {
  const GetHelpPage({super.key});

  @override
  State<GetHelpPage> createState() => _GetHelpPageState();
}

class _GetHelpPageState extends State<GetHelpPage> {
  final TextEditingController _searchController = TextEditingController();
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
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => DashboardPage(), transitionDuration: Duration.zero));
        break;
      case 'Health Plans':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const HealthPlansPage(), transitionDuration: Duration.zero));
        break;
      case 'Term Life Plans':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const TermPlansPage(), transitionDuration: Duration.zero));
        break;
      case 'Auto Insurance':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const LifeInsurancePage(), transitionDuration: Duration.zero));
        break;
      case 'Get Help':
        break;
      case 'Settings':
        // Navigate to settings
        break;
      case 'Profile':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const ProfilePage(), transitionDuration: Duration.zero));
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
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -50,
                          top: -50,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 64 : 24,
                            vertical: isDesktop ? 80 : 48,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const DashboardPage(), transitionDuration: Duration.zero)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(LucideIcons.arrowLeft, size: 16, color: Colors.white.withOpacity(0.8)),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Back to Dashboard',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.8),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                              const SizedBox(height: 24),
                              Text(
                                'Support Center',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                              ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: -0.2),
                              const SizedBox(height: 12),
                              Text(
                                'How can we help you\ntoday?',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: isDesktop ? 48 : 32,
                                  fontWeight: FontWeight.w800,
                                  height: 1.1,
                                ),
                              ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // --- CATEGORIES ---
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(isDesktop ? 64 : 24, 40, isDesktop ? 64 : 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Browse by Category',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _categories.map((cat) {
                              final isSelected = _selectedCategory == cat['name'];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: InkWell(
                                  onTap: () => setState(() => _selectedCategory = cat['name']!),
                                  borderRadius: BorderRadius.circular(12),
                                  child: AnimatedContainer(
                                    duration: 200.ms,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppColors.primary : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected ? AppColors.primary : Colors.grey.shade200,
                                      ),
                                      boxShadow: isSelected
                                          ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
                                          : [],
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          _getIconData(cat['icon']!),
                                          size: 18,
                                          color: isSelected ? Colors.white : Colors.grey.shade600,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          cat['name']!,
                                          style: GoogleFonts.inter(
                                            color: isSelected ? Colors.white : Colors.grey.shade700,
                                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
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
                      _FAQItem(
                        question: 'How do I download my policy document?',
                        answer: 'You can download your policy document by going to "Dashboard", selecting your active policy, and clicking the "Download PDF" button. A copy is also sent to your registered email.',
                        category: 'Policy',
                        index: 0,
                      ),
                      _FAQItem(
                        question: 'What is the claim settlement ratio?',
                        answer: 'Our claim settlement ratio for the last financial year was 98.7%. We pride ourselves on a transparent and fast claim process through our 10k+ network hospitals.',
                        category: 'Claims',
                        index: 1,
                      ),
                      _FAQItem(
                        question: 'Can I pay my premium in installments?',
                        answer: 'Yes, we offer monthly, quarterly, half-yearly, and annual payment frequencies. You can change your preference in the "Settings" menu or during renewal.',
                        category: 'Payments',
                        index: 2,
                      ),
                      _FAQItem(
                        question: 'How do I update my registered mobile number?',
                        answer: 'Go to your "Profile" page, click on the edit icon next to your phone number, and follow the OTP verification process to update it securely.',
                        category: 'Account',
                        index: 3,
                      ),
                      _FAQItem(
                        question: 'What is a 15-day free look period?',
                        answer: 'It is a period during which you can review the policy terms. If you are not satisfied, you can cancel the policy and get a refund of the premium paid (minus certain charges).',
                        category: 'Policy',
                        index: 4,
                      ),
                      _FAQItem(
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

  IconData _getIconData(String iconStr) {
    if (iconStr.contains('helpCircle')) return LucideIcons.helpCircle;
    if (iconStr.contains('fileText')) return LucideIcons.fileText;
    if (iconStr.contains('shield')) return LucideIcons.shield;
    if (iconStr.contains('creditCard')) return LucideIcons.creditCard;
    if (iconStr.contains('user')) return LucideIcons.user;
    return LucideIcons.helpCircle;
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;
  final String category;
  final int index;

  const _FAQItem({
    required this.question,
    required this.answer,
    required this.category,
    required this.index,
  });

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (val) => setState(() => _isExpanded = val),
          tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getCategoryIcon(widget.category),
              size: 20,
              color: AppColors.primary,
            ),
          ),
          title: Text(
            widget.question,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          trailing: Icon(
            _isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
            color: Colors.grey.shade400,
            size: 20,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Text(
                widget.answer,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: const Color(0xFF64748B),
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: (800 + (widget.index * 100)).ms).slideY(begin: 0.1);
  }

  IconData _getCategoryIcon(String cat) {
    switch (cat) {
      case 'Claims': return LucideIcons.fileText;
      case 'Policy': return LucideIcons.shield;
      case 'Payments': return LucideIcons.creditCard;
      case 'Account': return LucideIcons.user;
      default: return LucideIcons.helpCircle;
    }
  }
}
