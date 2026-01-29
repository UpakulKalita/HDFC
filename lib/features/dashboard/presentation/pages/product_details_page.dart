import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/product_details/product_hero.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/product_details/product_feature_grid.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/product_details/product_coverage_list.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/product_details/product_sticky_footer.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/product_details/product_summary_card.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/sidebar_widget.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/my_policies_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';

class ProductDetailsPage extends StatefulWidget {
  // Trigger rebuild for type change
  final String productName;
  final String productTagline;
  final Color themeColor;
  
  // Hero Data
  final String coverageAmount;
  final String claimsRatio;
  final String waitingPeriod;

  // Features
  final List<Map<String, dynamic>> features;

  // Coverage Lists
  final List<Map<String, String>> coveredItems;
  final List<Map<String, String>> notCoveredItems;

  // Pricing
  final String price;
  final String periodicity;
  final String? heroImage; // Added heroImage

  const ProductDetailsPage({
    super.key,
    required this.productName,
    required this.productTagline,
    required this.themeColor,
    required this.coverageAmount,
    required this.claimsRatio,
    required this.waitingPeriod,
    required this.features,
    required this.coveredItems,
    required this.notCoveredItems,
    required this.price,
    required this.periodicity,
    this.heroImage,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  void _onSidebarItemTap(String item) {
    switch (item) {
      case 'Dashboard':
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const DashboardPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 'Health Plans':
        Navigator.pop(context); // Go back to Health Plans list
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
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const LifeInsurancePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
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
      case 'My Policies':
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MyPoliciesPage(),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          if (isDesktop)
            SidebarWidget(
              activeItem: 'Health Plans',
              onItemTap: _onSidebarItemTap,
            ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: isDesktop
                        ? Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left Column: Content
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      ProductHero(
                                        title: widget.productName,
                                        tagline: widget.productTagline,
                                        coverage: widget.coverageAmount,
                                        claimsRatio: widget.claimsRatio,
                                        waitingPeriod: widget.waitingPeriod,
                                        themeColor: widget.themeColor,
                                        onBack: () => Navigator.pop(context),
                                        isCompact: true,
                                      ),
                                      const SizedBox(height: 32),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                        child: ProductFeatureGrid(
                                          features: widget.features,
                                          themeColor: widget.themeColor,
                                        ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                                      ),
                                      const SizedBox(height: 48),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                        child: ProductCoverageList(
                                          coveredItems: widget.coveredItems,
                                          notCoveredItems: widget.notCoveredItems,
                                        ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
                                      ),
                                      const SizedBox(height: 48),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 32),
                                // Right Column: Summary Card
                                Expanded(
                                  flex: 1,
                                  child: ProductSummaryCard(
                                    title: widget.productName,
                                    tagline: widget.productTagline,
                                    price: widget.price,
                                    periodicity: widget.periodicity,
                                    coverage: widget.coverageAmount,
                                    waitingPeriod: widget.waitingPeriod,
                                    themeColor: widget.themeColor,
                                    heroImage: widget.heroImage, // Pass heroImage
                                    onBuy: () {},
                                  ).animate().fadeIn(delay: 600.ms, duration: 500.ms).slideX(begin: 0.1, end: 0),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              ProductHero(
                                title: widget.productName,
                                tagline: widget.productTagline,
                                coverage: widget.coverageAmount,
                                claimsRatio: widget.claimsRatio,
                                waitingPeriod: widget.waitingPeriod,
                                themeColor: widget.themeColor,
                                onBack: () => Navigator.pop(context),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                                child: Column(
                                  children: [
                                    ProductFeatureGrid(
                                      features: widget.features,
                                      themeColor: widget.themeColor,
                                    ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                                    const SizedBox(height: 48),
                                    Divider(height: 1, color: Colors.grey.shade100),
                                    const SizedBox(height: 40),
                                    ProductCoverageList(
                                      coveredItems: widget.coveredItems,
                                      notCoveredItems: widget.notCoveredItems,
                                    ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
                                    const SizedBox(height: 40),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                if (!isDesktop) // Only show sticky footer on mobile
                  ProductStickyFooter(
                    price: widget.price,
                    periodicity: widget.periodicity,
                    themeColor: widget.themeColor,
                    onBuy: () {},
                  ).animate().fadeIn(delay: 700.ms, duration: 400.ms).slideY(begin: 1, end: 0),
              ],
            ),
          ),
        ],
      ),
      drawer: !isDesktop ? SidebarWidget(
        activeItem: 'Health Plans',
        onItemTap: _onSidebarItemTap,
      ) : null,
    );
  }
}
