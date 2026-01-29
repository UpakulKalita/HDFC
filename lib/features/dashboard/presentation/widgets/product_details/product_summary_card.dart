import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductSummaryCard extends StatelessWidget {
  final String title;
  final String tagline;
  final String price;
  final String periodicity;
  final String coverage;
  final String waitingPeriod;
  final Color themeColor;
  final VoidCallback onBuy;
  final String? heroImage; // Added heroImage

  const ProductSummaryCard({
    super.key,
    required this.title,
    required this.tagline,
    required this.price,
    required this.periodicity,
    required this.coverage,
    required this.waitingPeriod,
    required this.themeColor,
    required this.onBuy,
    this.heroImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Header Image with "Recommended" Badge
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.1),
                ),
                child: heroImage != null
                    ? Image.network(
                        heroImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(Icons.health_and_safety_outlined, size: 64, color: themeColor.withValues(alpha: 0.3)),
                        ),
                      )
                    : Center(
                        child: Icon(Icons.health_and_safety_outlined, size: 64, color: themeColor.withValues(alpha: 0.3)),
                      ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50), // Green like the reference
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        'Recommended',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Tags Row
                Row(
                  children: [
                    _buildTag('Health', themeColor),
                    const SizedBox(width: 8),
                    _buildTag('Tax Saver', Colors.grey.shade600),
                    const SizedBox(width: 8),
                    _buildTag('No Medical Test', Colors.grey.shade600),
                  ],
                ),
                const SizedBox(height: 16),

                // 3. Title
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E293B),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 24),

                // 4. Stats Boxes (Row of 3)
                Row(
                  children: [
                    Expanded(child: _buildStatBox('Coverage', coverage, Icons.shield_outlined, themeColor)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatBox('Claims', '98.5%', Icons.verified_outlined, themeColor)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatBox('Waiting', waitingPeriod, Icons.hourglass_empty, themeColor)),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(height: 32, color: Colors.grey.shade100),

                // 5. "Why Recommended" Bullets
                Text(
                  'Why Recommended',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 12),
                _buildBulletPoint('Covers 100% of hospitalization expenses.'),
                const SizedBox(height: 8),
                _buildBulletPoint('Includes dental and vision care treatments.'),
                
                const SizedBox(height: 32),

                // 6. Price & CTA
                Text(
                   price,
                   style: GoogleFonts.plusJakartaSans(
                     fontSize: 28,
                     fontWeight: FontWeight.w800,
                     color: const Color(0xFF1E293B),
                     height: 1,
                   ),
                ),
                Text(
                   'billed $periodicity',
                   style: GoogleFonts.plusJakartaSans(
                     fontSize: 13,
                     fontWeight: FontWeight.w500,
                     color: Colors.grey.shade400,
                   ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: onBuy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50), // Green CTA like reference
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'View Plan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
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

  Widget _buildTag(String text, Color color) {
    // Determine background based on color (helper logic)
    final isTheme = color == themeColor;
    final bgColor = isTheme ? color.withValues(alpha: 0.1) : Colors.grey.shade100;
    final textColor = isTheme ? color : const Color(0xFF64748B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isTheme ? color.withValues(alpha: 0.2) : Colors.transparent),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        color: const Color(0xFFF8FAFC),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
              letterSpacing: -0.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF475569),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
