import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/models/profile_details.dart';
import 'package:insurance_flutter/features/dashboard/presentation/services/profile_service.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/top_bar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<ProfileDetails> _profileFuture;
  final ProfileService _profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    _profileFuture = _profileService.getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Restored original background
      body: Row(
        children: [
          if (isDesktop)
            SidebarWidget(
              activeItem: 'My Profile',
              onItemTap: (item) => SidebarWidget.onTap(context, item),
            ),
          Expanded(
            child: FutureBuilder<ProfileDetails>(
              future: _profileFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading profile: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No profile data found.'));
                }

                final profile = snapshot.data!;
                return CustomScrollView(
                  slivers: [
                    // --- TOP BAR (My Profile) ---
                    SliverToBoxAdapter(
                      child: TopBarWidget(
                        isDesktop: isDesktop,
                        activeItem: 'My Profile',
                        showSearch: false,
                        showActions: false,
                        height: 140, // Increased height
                        automaticallyImplyLeading: false, // Hide back button
                        titleFontSize: 40, // Even bigger heading
                        titlePadding: EdgeInsets.only(
                          left: isDesktop ? 64 : 20,
                        ), // Align with body content (64 - default 20)
                        title: 'My Profile',
                        backgroundGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.primary, AppColors.primaryDark],
                        ),
                        activeItemColor: Colors.white,
                        backgroundDecoration: Positioned(
                          right:
                              -30, // Adjusted for better look with more height
                          top: -30,
                          child: Container(
                            width: 280, // Larger circle
                            height: 280,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // --- PROFILE IDENTITY (Name, Avatar, Email) ---
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 64 : 24,
                          vertical: 32,
                        ),
                        child: _buildProfileIdentity(profile),
                      ),
                    ),

                    // --- MAIN CONTENT (Specific Fields in Premium Card) ---
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 64 : 20,
                        vertical: 0, // Reduced top padding as identity is above
                      ),
                      sliver: SliverToBoxAdapter(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return _buildPremiumCard(
                                  title: 'Customer Details',
                                  icon: LucideIcons.userCheck,
                                  width: constraints.maxWidth,
                                  child: LayoutBuilder(
                                    builder: (context, innerConstraints) {
                                      // 2 Column Layout for the 8 fields
                                      double colWidth =
                                          (innerConstraints.maxWidth) / 2 - 20;
                                      if (colWidth < 280) {
                                        colWidth = innerConstraints.maxWidth;
                                      }

                                      return Wrap(
                                        spacing: 40,
                                        runSpacing: 40,
                                        children: [
                                          _buildReadOnlyField(
                                            'Name',
                                            profile.name,
                                            LucideIcons.user,
                                            width: colWidth,
                                          ),
                                          _buildReadOnlyField(
                                            'Marital Status',
                                            profile.maritialStatus,
                                            LucideIcons.heart,
                                            width: colWidth,
                                          ),
                                          _buildReadOnlyField(
                                            'Email',
                                            profile.email,
                                            LucideIcons.mail,
                                            width: colWidth,
                                          ),
                                          _buildReadOnlyField(
                                            'Occupation',
                                            profile.occupation,
                                            LucideIcons.briefcase,
                                            width: colWidth,
                                          ),
                                          _buildReadOnlyField(
                                            'Age',
                                            profile.age,
                                            LucideIcons.cake,
                                            width: colWidth,
                                          ),
                                          _buildReadOnlyField(
                                            'City',
                                            profile.city,
                                            LucideIcons.mapPin,
                                            width: colWidth,
                                          ),
                                          _buildReadOnlyField(
                                            'Gender',
                                            profile.gender,
                                            LucideIcons.user,
                                            width: colWidth,
                                          ),
                                          _buildReadOnlyField(
                                            'Number of Dependents',
                                            profile.dependents,
                                            LucideIcons.users,
                                            width: colWidth,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                                .animate()
                                .fadeIn(duration: 600.ms, delay: 200.ms)
                                .slideY(begin: 0.1);
                          },
                        ),
                      ),
                    ),

                    // Extra padding at bottom
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      drawer: isDesktop
          ? null
          : SidebarWidget(
              activeItem: 'My Profile',
              onItemTap: (item) => SidebarWidget.onTap(context, item),
            ),
    );
  }

  Widget _buildProfileIdentity(ProfileDetails profile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.1),
                    Colors.white,
                  ],
                ),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFFEFF6FF),
                child: Text(
                  _getInitials(profile.name),
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
          ],
        ),
        const SizedBox(width: 24),

        // User Details
        Expanded(
          child:
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            profile.name,
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1E293B), // Dark text
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            LucideIcons.badgeCheck,
                            size: 20,
                            color: AppColors.primary, // Blue badge
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Email
                      Row(
                        children: [
                          Icon(
                            LucideIcons.mail,
                            size: 16,
                            color: const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            profile.email,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 300.ms)
                  .slideX(begin: 0.05),
        ),
      ],
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
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64748B).withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child:
          child, // Removed the Title row inside the card to match "exact box" if it's just fields
    );
  }

  Widget _buildReadOnlyField(
    String label,
    String value,
    IconData icon, {
    double? width,
  }) {
    return SizedBox(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF3B82F6)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
    }
    return name.substring(0, min(2, name.length)).toUpperCase();
  }
}
