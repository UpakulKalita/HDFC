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

class PremiumCalculatorPage extends StatefulWidget {
  const PremiumCalculatorPage({super.key});

  @override
  State<PremiumCalculatorPage> createState() => _PremiumCalculatorPageState();
}

class _PremiumCalculatorPageState extends State<PremiumCalculatorPage> {
  double _sumInsured = 500000;
  int _age = 25;
  int _term = 10;
  bool _includeCriticalIllness = false;
  bool _includeAccidentCover = false;

  double _calculateMonthlyPremium() {
    // Basic mock calculation logic
    double baseRate = (_sumInsured / 1800) * (_age / 18);
    double termDiscount = 1 - (_term / 120);
    double addOns = (_includeCriticalIllness ? 180 : 0) + (_includeAccidentCover ? 120 : 0);
    return (baseRate * termDiscount) + addOns;
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
    final isDesktop = screenWidth >= 1100; // Increased threshold for side-by-side
    final premium = _calculateMonthlyPremium();
    final accentColor = const Color(0xFF2563EB); // Professional Blue

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Slightly different background
      body: Row(
        children: [
          if (isDesktop) SidebarWidget(activeItem: 'Dashboard', onItemTap: _onSidebarItemTap),
          Expanded(
            child: CustomScrollView(
              slivers: [
                // --- HERO HEADER ---
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
                                    Icon(LucideIcons.arrowLeft,
                                        size: 16,
                                        color: Colors.white.withOpacity(0.8)),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Back to Dashboard',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                              const SizedBox(height: 32),
                              Text(
                                'Premium Calculator',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: isDesktop ? 56 : 36,
                                  fontWeight: FontWeight.w900,
                                  height: 1,
                                ),
                              ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.1),
                              const SizedBox(height: 16),
                              Text(
                                'Personalize your coverage and see how it affects your cost.',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 18,
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

                // --- CONTENT REDESIGN ---
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(isDesktop ? 64 : 24, 40, isDesktop ? 64 : 24, 64),
                  sliver: SliverToBoxAdapter(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: isDesktop 
                        ? IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(flex: 7, child: _buildModernInputPanel(accentColor)),
                                const SizedBox(width: 32),
                                Expanded(flex: 4, child: _buildStickyResults(premium, accentColor)),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              _buildModernInputPanel(accentColor),
                              const SizedBox(height: 32),
                              _buildStickyResults(premium, accentColor),
                            ],
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernInputPanel(Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24, offset: const Offset(0, 12)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(width: 12),
              Text(
                'Parameter Configuration',
                style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: const Color(0xFF1E293B)),
              ),
            ],
          ),
          const SizedBox(height: 48),
          _buildCompactSliderTile(
            label: 'Sum Insured Amount',
            value: _sumInsured,
            min: 100000,
            max: 10000000,
            displayValue: '₹${(_sumInsured / 100000).toStringAsFixed(1)} Lacs',
            onChanged: (val) => setState(() => _sumInsured = val),
            accentColor: accentColor,
            icon: LucideIcons.shieldCheck,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _buildCompactSliderTile(
                  label: 'Insured Age',
                  value: _age.toDouble(),
                  min: 18,
                  max: 75,
                  displayValue: '$_age Yrs',
                  onChanged: (val) => setState(() => _age = val.toInt()),
                  accentColor: accentColor,
                  icon: LucideIcons.user,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildCompactSliderTile(
                  label: 'Coverage Term',
                  value: _term.toDouble(),
                  min: 1,
                  max: 40,
                  displayValue: '$_term Yrs',
                  onChanged: (val) => setState(() => _term = val.toInt()),
                  accentColor: accentColor,
                  icon: LucideIcons.calendar,
                ),
              ),
            ],
          ),
          const SizedBox(height: 56),
          Text(
            'Supplemental Benefits',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildAddOnToggle(
                  title: 'Critical Illness',
                  subtitle: 'Add severe disease protection',
                  selected: _includeCriticalIllness,
                  onTap: () => setState(() => _includeCriticalIllness = !_includeCriticalIllness),
                  accentColor: accentColor,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildAddOnToggle(
                  title: 'Accident Cover',
                  subtitle: '24/7 emergency assistance',
                  selected: _includeAccidentCover,
                  onTap: () => setState(() => _includeAccidentCover = !_includeAccidentCover),
                  accentColor: accentColor,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms);
  }

  Widget _buildCompactSliderTile({
    required String label,
    required double value,
    required double min,
    required double max,
    required String displayValue,
    required Function(double) onChanged,
    required Color accentColor,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
            const SizedBox(width: 8),
            Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF64748B))),
            const Spacer(),
            Text(displayValue, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: accentColor)),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: accentColor,
            inactiveTrackColor: accentColor.withOpacity(0.1),
            thumbColor: Colors.white,
            overlayColor: accentColor.withOpacity(0.1),
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8, elevation: 6),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildAddOnToggle({
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
    required Color accentColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: selected ? accentColor.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? accentColor : Colors.grey.shade200, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B))),
                  const SizedBox(height: 4),
                  Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B))),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: selected ? accentColor : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: selected ? accentColor : Colors.grey.shade300, width: 2),
              ),
              child: selected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyResults(double premium, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.2), blurRadius: 40, offset: const Offset(0, 20)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUOTATION SUMMARY',
            style: GoogleFonts.inter(color: Colors.blue.shade300, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2),
          ),
          const SizedBox(height: 32),
          Text(
            'Your monthly investment',
            style: GoogleFonts.inter(color: Colors.blueGrey.shade400, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '₹',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w300),
              ),
              const SizedBox(width: 6),
              Text(
                premium.toStringAsFixed(0),
                style: GoogleFonts.inter(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w900, letterSpacing: -1),
              ),
            ],
          ),
          const SizedBox(height: 48),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 40),
          _buildDetailRow('Estimated Sum', '₹${(_sumInsured / 100000).toStringAsFixed(1)}L'),
          _buildDetailRow('Policy Term', '$_term Years'),
          _buildDetailRow('Plan Coverage', 'Global + Addons'),
          const Spacer(),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 68,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: Text('Get Official Quote', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 200.ms);
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.inter(
                  color: Colors.blueGrey.shade400,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          Text(value,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
