import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/features/dashboard/domain/entities/recommendation.dart';
import 'package:insurance_flutter/features/dashboard/presentation/widgets/dashboard_plan_card.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/product_details_page.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RecommendationsSection extends StatelessWidget {
  final List<Recommendation> recommendations;

  const RecommendationsSection({
    super.key,
    required this.recommendations,
  });

  @override
  Widget build(BuildContext context) {
    if (recommendations.isEmpty) {
      return const SizedBox.shrink(); // Hide if no recommendations
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommendations for You',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Based on your profile and current coverage',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 24),

        // -------- RECOMMENDATIONS GRID --------
        LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth;
            if (constraints.maxWidth > 1100) {
              cardWidth = (constraints.maxWidth - 48) / 3;
            } else if (constraints.maxWidth > 700) {
              cardWidth = (constraints.maxWidth - 24) / 2;
            } else {
              cardWidth = constraints.maxWidth;
            }

            return Wrap(
              spacing: 24,
              runSpacing: 24,
              children: recommendations.map((recommendation) {
                return SizedBox(
                  width: cardWidth,
                  child: DashboardPlanCard(
                    type: recommendation.type,
                    typeColor: recommendation.typeColor,
                    title: recommendation.title,
                    price: recommendation.price,
                    coverage: recommendation.coverage,
                    claimRatio: recommendation.claimRatio,
                    waitingPeriod: recommendation.waitingPeriod,
                    features: recommendation.features,
                    tags: recommendation.tags,
                    imageUrl: recommendation.imageUrl,
                    onViewDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            productName: recommendation.title,
                            productTagline: 'Recommended for you',
                            coverageAmount: recommendation.coverage,
                            claimsRatio: recommendation.claimRatio,
                            waitingPeriod: recommendation.waitingPeriod,
                            features: recommendation.features.map((f) => {
                              'icon': LucideIcons.checkCircle,
                              'title': 'Plan Feature',
                              'desc': f,
                            }).toList(),
                            coveredItems: const [
                              {'title': 'Hospitalization', 'subtitle': 'In-patient care expenses covered.'},
                              {'title': 'Surgery', 'subtitle': 'Major and minor surgical procedures.'},
                              {'title': 'Medication', 'subtitle': 'Prescribed medicines during stay.'}
                            ],
                            notCoveredItems: const [
                              {'title': 'Cosmetic Surgery', 'subtitle': 'Aesthetic enhancements not covered.'},
                              {'title': 'Experimental Treatment', 'subtitle': 'Unproven medical procedures.'}
                            ],
                            themeColor: recommendation.typeColor,
                            price: recommendation.price,
                            periodicity: 'yearly',
                            heroImage: recommendation.imageUrl,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
