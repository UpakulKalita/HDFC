import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
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
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) => const GetHelpPage(), transitionDuration: Duration.zero));
        break;
      case 'Settings':
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
                  child: _buildHeroHeader(completion, isDesktop),
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
                                _buildPremiumCard(
                                  title: 'Account Information',
                                  icon: LucideIcons.user,
                                  width: isDesktop ? (constraints.maxWidth - 24) * 0.6 : constraints.maxWidth,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            _buildModernField('Full Name', _nameController, LucideIcons.user),
                                            _buildModernField('Email Address', _emailController, LucideIcons.mail),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            _buildModernField('Phone Number', _phoneController, LucideIcons.phone),
                                            _buildModernField('Date of Birth', TextEditingController(text: '12 May 1995'), LucideIcons.calendar),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.1),

                                // Bento Card 2: Profile Strength
                                _buildPremiumCard(
                                  title: 'Profile Status',
                                  icon: LucideIcons.activity,
                                  width: isDesktop ? (constraints.maxWidth - 24) * 0.4 - 1 : constraints.maxWidth,
                                  child: Column(
                                    children: [
                                      _buildStrengthIndicator(completion),
                                      const SizedBox(height: 24),
                                      _buildStatusItem(LucideIcons.shieldCheck, 'Verified Account', Colors.green),
                                      _buildStatusItem(LucideIcons.zap, 'Instant Matching On', Colors.orange),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideY(begin: 0.1),

                                // Bento Card 3: Lifestyle & Insurance
                                _buildPremiumCard(
                                  title: 'Insurance Profile',
                                  icon: LucideIcons.shieldCheck,
                                  width: isDesktop ? (constraints.maxWidth - 24) * 0.5 : constraints.maxWidth,
                                  child: Column(
                                    children: [
                                      _buildModernDropdown('Marital Status', _maritalStatus, ['Single', 'Married', 'Divorced', 'Widowed'], (val) => setState(() => _maritalStatus = val!)),
                                      _buildModernDropdown('Tobacco / Smoking', _tobacco, ['No', 'Yes', 'Occasional'], (val) => setState(() => _tobacco = val!)),
                                      _buildModernField('Occupation', TextEditingController(text: _occupation), LucideIcons.briefcase, onChanged: (val) => _occupation = val),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.1),

                                // Bento Card 4: Dependents & Family
                                _buildPremiumCard(
                                  title: 'Family & Dependents',
                                  icon: LucideIcons.users,
                                  width: isDesktop ? (constraints.maxWidth - 24) * 0.5 - 1 : constraints.maxWidth,
                                  child: Column(
                                    children: [
                                      _buildCounterField('Number of Children', _children, (val) => setState(() => _children = val)),
                                      const SizedBox(height: 20),
                                      _buildCounterField('Dependent Parents', _dependentParents, (val) => setState(() => _dependentParents = val)),
                                      const SizedBox(height: 20),
                                      _buildModernDropdown('Annual Income', _income, ['< ₹5L', '₹5L - ₹10L', '₹10L - ₹15L', '₹15L+'], (val) => setState(() => _income = val!)),
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

  Widget _buildHeroHeader(double completion, bool isDesktop) {
    return Container(
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
          // Background Circle Decoration
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
          
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 64 : 24,
              vertical: isDesktop ? 48 : 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back to Dashboard Button
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

                const SizedBox(height: 32),

                // Profile Info Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar with Edit Button
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.white70],
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 54,
                            backgroundColor: Colors.white,
                            backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&q=80&w=200'),
                          ),
                        ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryDark,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(LucideIcons.camera, color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 32),
                    
                    // User Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                _nameController.text,
                                style: GoogleFonts.inter(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                                ),
                                child: Text(
                                  'Pro Member',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Premium Plan Active since Jan 2024',
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _buildHeroStat('Policies', '04'),
                              _buildHeroDivider(),
                              _buildHeroStat('Claims', '00'),
                              _buildHeroDivider(),
                              _buildHeroStat('Premium', '₹12K/yr'),
                            ],
                          ),
                        ],
                      ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideX(begin: 0.05),
                    ),
                    
                    // Save Button (Desktop)
                    if (isDesktop)
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(LucideIcons.save, size: 18, color: AppColors.primary),
                        label: const Text('Save Profile'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                      ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.white12,
      margin: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Widget _buildPremiumCard({
    required String title,
    required IconData icon,
    required Widget child,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: AppColors.primary),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(LucideIcons.moreHorizontal, size: 20, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 32),
          child,
        ],
      ),
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

  Widget _buildStrengthIndicator(double completion) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: CircularProgressIndicator(
                value: completion,
                strokeWidth: 10,
                backgroundColor: Colors.grey.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            Column(
              children: [
                Text(
                  '${(completion * 100).toInt()}%',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'Complete',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModernField(String label, TextEditingController controller, IconData icon, {Function(String)? onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 18, color: AppColors.primary.withOpacity(0.5)),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            ),
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernDropdown(String label, String value, List<String> items, Function(String?) onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(LucideIcons.chevronDown, size: 18),
                items: items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterField(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () => onChanged(value > 0 ? value - 1 : 0), icon: const Icon(LucideIcons.minusCircle, size: 20, color: Colors.grey)),
              Text(
                value.toString(),
                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF1E293B)),
              ),
              IconButton(onPressed: () => onChanged(value + 1), icon: const Icon(LucideIcons.plusCircle, size: 20, color: AppColors.primary)),
            ],
          ),
        ),
      ],
    );
  }
}
