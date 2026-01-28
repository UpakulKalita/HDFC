import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GetHelpPage extends StatefulWidget {
  const GetHelpPage({super.key});

  @override
  State<GetHelpPage> createState() => _GetHelpPageState();
}

class _GetHelpPageState extends State<GetHelpPage> {
  void _onSidebarItemTap(String item) {
    // Handle navigation based on the selected item
    switch (item) {
      case 'Dashboard':
        Navigator.of(context).pushNamed('/dashboard');
        break;
      case 'Health Plans':
        Navigator.of(context).pushNamed('/health-plans');
        break;
      case 'Term Plans':
        Navigator.of(context).pushNamed('/term-plans');
        break;
      case 'Life Insurance':
        Navigator.of(context).pushNamed('/life-insurance');
        break;
      case 'Get Help':
        // Already on this page
        break;
      case 'Settings':
        Navigator.of(context).pushNamed('/settings');
        break;
      case 'Profile':
        Navigator.of(context).pushNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.grey.shade50,
            child: Row(
              children: [
                if (isDesktop) ...[
                  /// LEFT SIDEBAR - Full Height (Desktop only)
                  SidebarWidget(
                    activeItem: 'Get Help',
                    onItemTap: _onSidebarItemTap,
                  ),
                ],

                /// MAIN CONTENT AREA
                Expanded(
                  child: Column(
                    children: [
                      /// TOP BAR
                      _buildTopBar(context, isDesktop: isDesktop),

                      /// MAIN CONTENT
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(32),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 1400),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Page Header
                                  Text(
                                    'Get Help & Support',
                                    style: GoogleFonts.inter(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Find answers to your questions and get assistance',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),


                                  // FAQ Section
                                  Text(
                                    'Frequently Asked Questions',
                                    style: GoogleFonts.inter(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  _buildFAQItem(
                                    question: 'How do I file a claim?',
                                    answer: 'You can file a claim through our mobile app, website, or by calling our helpline. Make sure you have all necessary documents ready including policy details, incident reports, and medical certificates.',
                                  ),
                                  _buildFAQItem(
                                    question: 'What documents do I need for health insurance?',
                                    answer: 'For health insurance claims, you typically need: policy document, medical bills, doctor\'s prescription, diagnostic reports, discharge summary (for hospitalization), and identity proof.',
                                  ),
                                  _buildFAQItem(
                                    question: 'How long does claim processing take?',
                                    answer: 'Most claims are processed within 7-10 working days. Cashless claims at network hospitals are settled instantly. Reimbursement claims may take longer depending on document verification.',
                                  ),
                                  _buildFAQItem(
                                    question: 'Can I modify my existing policy?',
                                    answer: 'Yes, you can modify your policy coverage, add riders, or change premium payment frequency. Contact our customer service or visit your nearest branch for assistance.',
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: isDesktop ? null : SidebarWidget(
        activeItem: 'Get Help',
        onItemTap: _onSidebarItemTap,
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, {required bool isDesktop}) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      leading: isDesktop ? null : Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Container(
        width: isDesktop ? 400 : 280,
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey.shade600, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: isDesktop ? 'Search help topics...' : 'Search...',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                style: GoogleFonts.inter(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black87, size: 24),
          onPressed: () {},
          tooltip: 'Notifications',
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person, color: Colors.black87, size: 20),
          label: Text(
            'My Profile',
            style: GoogleFonts.inter(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.logout, color: Colors.red.shade700, size: 20),
          onPressed: () {},
          tooltip: 'Logout',
        ),
        const SizedBox(width: 12),
      ],
    );
  }



  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
