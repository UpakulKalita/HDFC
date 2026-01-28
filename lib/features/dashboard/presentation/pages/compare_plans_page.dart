import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ComparePlansPage extends StatefulWidget {
  const ComparePlansPage({super.key});

  @override
  State<ComparePlansPage> createState() => _ComparePlansPageState();
}

class _PlanModel {
  final String name;
  final String monthlyPremium;
  final String sumInsured;
  final String cashlessHospitals;
  final String noClaimBonus;
  final String roomRentLimit;
  final String healthCheckup;
  final String globalCover;
  final double score; // Mock score for AI recommendation

  _PlanModel({
    required this.name,
    required this.monthlyPremium,
    required this.sumInsured,
    required this.cashlessHospitals,
    required this.noClaimBonus,
    required this.roomRentLimit,
    required this.healthCheckup,
    required this.globalCover,
    required this.score,
  });
}

class _ComparePlansPageState extends State<ComparePlansPage> {
  String _selectedCategory = 'Health';
  final List<String> _categories = ['Health', 'Auto', 'Term Life'];

  late _PlanModel _plan1;
  late _PlanModel _plan2;

  final Map<String, List<_PlanModel>> _plansData = {
    'Health': [
      _PlanModel(name: 'Standard Life', monthlyPremium: '₹450', sumInsured: '₹5L', cashlessHospitals: '500+', noClaimBonus: '10%', roomRentLimit: '1% of SI', healthCheckup: '2 yrs', globalCover: 'N/A', score: 72),
      _PlanModel(name: 'Premium Care', monthlyPremium: '₹850', sumInsured: '₹15L', cashlessHospitals: '2,500+', noClaimBonus: '25%', roomRentLimit: 'No Limit', healthCheckup: 'Every Yr', globalCover: 'N/A', score: 88),
      _PlanModel(name: 'Elite Health', monthlyPremium: '₹1,250', sumInsured: '₹50L', cashlessHospitals: '10,000+', noClaimBonus: '50%', roomRentLimit: 'Suite', healthCheckup: '2x / Yr', globalCover: 'Yes', score: 94),
    ],
    'Auto': [
      _PlanModel(name: 'Budget Drive', monthlyPremium: '₹300', sumInsured: 'IDV 80%', cashlessHospitals: '200+', noClaimBonus: '5%', roomRentLimit: 'N/A', healthCheckup: 'N/A', globalCover: 'N/A', score: 65),
      _PlanModel(name: 'Silver Shield', monthlyPremium: '₹600', sumInsured: 'IDV 95%', cashlessHospitals: '800+', noClaimBonus: '20%', roomRentLimit: 'N/A', healthCheckup: 'N/A', globalCover: 'N/A', score: 82),
      _PlanModel(name: 'Gold Plate', monthlyPremium: '₹1,100', sumInsured: 'IDV 100%', cashlessHospitals: '2,000+', noClaimBonus: '50%', roomRentLimit: 'N/A', healthCheckup: 'N/A', globalCover: 'Yes', score: 91),
    ],
    'Term Life': [
      _PlanModel(name: 'Basic Term', monthlyPremium: '₹250', sumInsured: '₹25L', cashlessHospitals: 'N/A', noClaimBonus: 'N/A', roomRentLimit: 'N/A', healthCheckup: 'N/A', globalCover: 'N/A', score: 70),
      _PlanModel(name: 'Secure Life', monthlyPremium: '₹500', sumInsured: '₹1Cr', cashlessHospitals: 'N/A', noClaimBonus: 'N/A', roomRentLimit: 'N/A', healthCheckup: 'Every Yr', globalCover: 'N/A', score: 85),
      _PlanModel(name: 'Family Elite', monthlyPremium: '₹950', sumInsured: '₹5Cr', cashlessHospitals: 'N/A', noClaimBonus: 'N/A', roomRentLimit: 'N/A', healthCheckup: 'Every Yr', globalCover: 'Yes', score: 95),
    ],
  };

  @override
  void initState() {
    super.initState();
    _plan1 = _plansData['Health']![0];
    _plan2 = _plansData['Health']![2];
  }

  void _onCategoryChanged(String cat) {
    setState(() {
      _selectedCategory = cat;
      _plan1 = _plansData[cat]![0];
      _plan2 = _plansData[cat]![1];
    });
  }

  _PlanModel? _getRecommendedPlan() {
    if (_plan1.score > _plan2.score) return _plan1;
    if (_plan2.score > _plan1.score) return _plan2;
    return null;
  }

  void _onSidebarItemTap(String item) {
    switch (item) {
      case 'Dashboard':
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const DashboardPage(), transitionDuration: Duration.zero));
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
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const GetHelpPage(), transitionDuration: Duration.zero));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;
    final recommended = _getRecommendedPlan();

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
                          padding: EdgeInsets.fromLTRB(
                            isDesktop ? 64 : 24,
                            isDesktop ? 80 : 48,
                            isDesktop ? 64 : 24,
                            isDesktop ? 80 : 48,
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
                                'Plan Comparison',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: isDesktop ? 48 : 32,
                                  fontWeight: FontWeight.w800,
                                  height: 1.1,
                                ),
                              ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.1),
                              const SizedBox(height: 12),
                              Text(
                                'Compare any two plans to see which fits your profile best.',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ).animate().fadeIn(duration: 800.ms, delay: 400.ms),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // --- CATEGORY FILTERS ---
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(isDesktop ? 64 : 24, 40, isDesktop ? 64 : 24, 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _categories.map((cat) {
                          final isSelected = _selectedCategory == cat;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ActionChip(
                              label: Text(cat),
                              onPressed: () => _onCategoryChanged(cat),
                              backgroundColor: isSelected ? AppColors.primary : Colors.white,
                              labelStyle: GoogleFonts.inter(
                                color: isSelected ? Colors.white : Colors.grey.shade700,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              ),
                              side: BorderSide(color: isSelected ? AppColors.primary : Colors.grey.shade200),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                // --- CONSOLIDATED COMPARISON TABLE ---
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(isDesktop ? 64 : 24, 40, isDesktop ? 64 : 24, 64),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // --- TABLE HEADER: SELECTORS ---
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                              border: Border(bottom: Border.all(color: Colors.grey.shade200).top),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Plan Selection:',
                                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w900, color: const Color(0xFF1E293B)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: _buildTableSelector(_plan1, (p) => setState(() => _plan1 = p), AppColors.primary),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: _buildTableSelector(_plan2, (p) => setState(() => _plan2 = p), Colors.deepPurple),
                                ),
                              ],
                            ),
                          ),

                          // --- TABLE SUB-HEADER: PLAN INFO ---
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                            child: Row(
                              children: [
                                const Expanded(flex: 2, child: SizedBox()),
                                Expanded(
                                  flex: 3,
                                  child: _buildPlanHeader(_plan1, recommended == _plan1, AppColors.primary),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: _buildPlanHeader(_plan2, recommended == _plan2, Colors.deepPurple),
                                ),
                              ],
                            ),
                          ),

                          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

                          // --- COMPARISON BODY ---
                          _buildTableMetricRow('Monthly Premium', _plan1.monthlyPremium, _plan2.monthlyPremium, isPremium: true),
                          _buildTableMetricRow('Sum Insured', _plan1.sumInsured, _plan2.sumInsured),
                          _buildTableMetricRow('Cashless Hospitals', _plan1.cashlessHospitals, _plan2.cashlessHospitals),
                          _buildTableMetricRow('No Claim Bonus', _plan1.noClaimBonus, _plan2.noClaimBonus),
                          _buildTableMetricRow('Room Rent Limit', _plan1.roomRentLimit, _plan2.roomRentLimit),
                          _buildTableMetricRow('Health Checkup', _plan1.healthCheckup, _plan2.healthCheckup),
                          _buildTableMetricRow('Global Cover', _plan1.globalCover, _plan2.globalCover),
                          
                          const SizedBox(height: 24),
                        ],
                      ),
                    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableSelector(_PlanModel currentPlan, Function(_PlanModel) onSelected, Color activeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButton<_PlanModel>(
        value: currentPlan,
        isExpanded: true,
        icon: Icon(LucideIcons.chevronDown, size: 16, color: activeColor),
        underline: const SizedBox(),
        items: _plansData[_selectedCategory]!.map((p) {
          return DropdownMenuItem<_PlanModel>(
            value: p,
            child: Text(p.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B))),
          );
        }).toList(),
        onChanged: (p) {
          if (p != null) onSelected(p);
        },
      ),
    );
  }

  Widget _buildPlanHeader(_PlanModel plan, bool isRecommended, Color accentColor) {
    return Column(
      children: [
        if (isRecommended)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [accentColor, accentColor.withOpacity(0.7)]),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: accentColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Text(
              'HIGHLY RECOMMENDED',
              style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.5),
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true)).shimmer(duration: 1.5.seconds)
        else
          const SizedBox(height: 30),
        FittedBox(
          child: Text(
            plan.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, color: const Color(0xFF1E293B)),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'SCORE: ${plan.score.toInt()}%',
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: accentColor, letterSpacing: 1),
        ),
      ],
    );
  }

  Widget _buildTableMetricRow(String label, String val1, String val2, {bool isPremium = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF64748B)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  val1,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: isPremium ? FontWeight.w900 : FontWeight.w600,
                    color: isPremium ? AppColors.primary : const Color(0xFF1E293B),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  val2,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: isPremium ? FontWeight.w900 : FontWeight.w600,
                    color: isPremium ? Colors.deepPurple : const Color(0xFF1E293B),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



