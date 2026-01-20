import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'plan_card.dart';

class RecommendationsList extends StatelessWidget {
  const RecommendationsList({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the cards list to reuse in both layouts
    final List<Widget> cards = [
      const PlanCard(
        title: "Health Secure Gold",
        category: "Health",
        amount: "₹ 5 Lakhs Coverage",
        price: "₹ 650",
        color: Color(0xFF00C853), // Green
        iconData: LucideIcons.heartPulse,
      ),
      const PlanCard(
        title: "Life Shield Plus",
        category: "Life Insurance",
        amount: "₹ 1 Crore Coverage",
        price: "₹ 900",
        color: Color(0xFF2962FF), // Blue
        iconData: LucideIcons.shield,
      ),
      const PlanCard(
        title: "Home Protect 360",
        category: "Home & Property",
        amount: "₹ 25 Lakhs Coverage",
        price: "₹ 700",
        color: Color(0xFFFF6D00), // Orange
        iconData: LucideIcons.home,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint for switching to horizontal layout
        // Lowered to 500 to ensure it triggers inside the 70% width column on desktops
        if (constraints.maxWidth > 500) {
          // Horizontal Layout: Remove padding to let cards fill the width of the parent column
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 16), // Reduced spacing
              Expanded(child: cards[1]),
              const SizedBox(width: 16), // Reduced spacing
              Expanded(child: cards[2]),
            ],
          );
        } else {
          // Mobile / Tablet Vertical Layout
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cards,
          );
        }
      },
    );
  }
}