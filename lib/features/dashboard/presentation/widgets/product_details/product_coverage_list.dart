import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCoverageList extends StatelessWidget {
  final List<Map<String, String>> coveredItems;
  final List<Map<String, String>> notCoveredItems;

  const ProductCoverageList({
    super.key,
    required this.coveredItems,
    required this.notCoveredItems,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 800; // Threshold for 2-column layout

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Covered Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('What\'s Covered', const Color(0xFF10B981)),
                    const SizedBox(height: 20),
                    ...coveredItems.map((item) => _buildListItem(item, true)),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              // Not Covered Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('What\'s Not Covered', const Color(0xFFEF4444)),
                    const SizedBox(height: 20),
                    ...notCoveredItems.map((item) => _buildListItem(item, false)),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Covered
              _buildSectionHeader('What\'s Covered', const Color(0xFF10B981)), // Green
              const SizedBox(height: 20),
              ...coveredItems.map((item) => _buildListItem(item, true)),
              
              const SizedBox(height: 32),
              
              // Not Covered
              _buildSectionHeader('What\'s Not Covered', const Color(0xFFEF4444)), // Red
              const SizedBox(height: 16),
              ...notCoveredItems.map((item) => _buildListItem(item, false)),
            ],
          );
        }
      },
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(Map<String, String> item, bool isCovered) {
    final color = isCovered ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final title = item['title'] ?? '';
    final subtitle = item['subtitle'] ?? '';
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16), // Increased spacing for double line
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Top align for multi-line
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2), // Align icon with text top
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCovered ? Icons.check_rounded : Icons.close_rounded,
                size: 14,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF334155),
                    height: 1.4,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B), // Subtle grey
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
