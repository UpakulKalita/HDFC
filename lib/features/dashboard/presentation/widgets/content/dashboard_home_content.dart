import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'promo_banner.dart';
import 'section_title.dart';
import 'recommendations_list.dart';
import 'premium_calculator_widget.dart';
import 'user_profile_insight_card.dart';
import 'dashboard_quick_actions.dart';
import 'footer.dart';

class DashboardHomeContent extends StatelessWidget {
  const DashboardHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // We'll define a base delay for staggering
    const int staggerBase = 100;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive Breakpoint
        final bool isDesktop = constraints.maxWidth > 900;

        // The content lists are defined here to be reused in both layouts
        final mainContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const PromoBanner()
                .animate(delay: (staggerBase * 1).ms)
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.95, 0.95), duration: 600.ms, curve: Curves.easeOutBack),
                
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionTitle(title: "Recommended for You"),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF2563EB), // AppColors.primaryBlue
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  child: Row(
                    children: const [
                      Text("View More"),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
                ),
              ],
            )
                .animate(delay: (staggerBase * 2).ms)
                .fadeIn()
                .slideX(begin: -0.1, end: 0),
                
            const SizedBox(height: 16),

            const RecommendationsList()
                .animate(delay: (staggerBase * 2.5).ms)
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
          ],
        );

        final sidebarContent = Column(
          children: [
             // Removed internal top spacing as container handles padding
             const PremiumCalculatorWidget()
                .animate(delay: (staggerBase * 3).ms)
                .fadeIn()
                .slideX(begin: 0.2, end: 0, curve: Curves.easeOut),

             const UserProfileInsightCard()
                .animate(delay: (staggerBase * 3.2).ms)
                .fadeIn(),
                
             // Removed spacing to move Quick Action up as requested
             
             const QuickActionsPanel()
                .animate(delay: (staggerBase * 3.5).ms)
                .fadeIn()
                .slideX(begin: 0.2, end: 0, curve: Curves.easeOut),
          ],
        );

        if (isDesktop) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: mainContent),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 3, 
                    child: Column(
                      children: [
                        const SizedBox(height: 20), // Align with PromoBanner which has 20px top spacing
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: sidebarContent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              const Footer().animate(delay: (staggerBase * 5).ms).fadeIn(),
              const SizedBox(height: 20),
            ],
          );
        } else {
          // Tablet / Mobile Layout (Stacked)
          return Column(
            children: [
              mainContent,
              const SizedBox(height: 40),
              sidebarContent,
              const SizedBox(height: 60),
              const Footer().animate(delay: (staggerBase * 5).ms).fadeIn(),
              const SizedBox(height: 20),
            ],
          );
        }
      },
    );
  }
}
