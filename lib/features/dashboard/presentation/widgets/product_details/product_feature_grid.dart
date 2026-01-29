import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProductFeatureGrid extends StatelessWidget {
  final List<Map<String, dynamic>> features; // {icon, title, desc}
  final Color themeColor;

  const ProductFeatureGrid({
    super.key,
    required this.features,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why this plan stands out',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            // 4 columns on Desktop (>900), 3 on Tablet (>600), 2 on Mobile
            final int crossAxisCount = width > 900 ? 4 : (width > 600 ? 3 : 2);
            // Adjust aspect ratio based on content density - Higher ratio = shorter cards
            final double aspectRatio = width > 900 ? 2.2 : (width > 600 ? 2.0 : 1.6);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16, // Tighter spacing
                mainAxisSpacing: 16,
                childAspectRatio: aspectRatio,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                final f = features[index];
                return _FeatureCard(
                  title: f['title'] as String,
                  desc: f['desc'] as String,
                  icon: f['icon'] as IconData,
                  themeColor: themeColor,
                  index: index,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final String title;
  final String desc;
  final IconData icon;
  final Color themeColor;
  final int index;

  const _FeatureCard({
    required this.title,
    required this.desc,
    required this.icon,
    required this.themeColor,
    required this.index,
  });

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(12), // Tighter padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), 
          border: Border.all(
            color: _isHovered 
                ? widget.themeColor.withValues(alpha: 0.3) 
                : Colors.grey.shade100,
            width: 1.0,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: widget.themeColor.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row( // Switch to Row for ultra compact height
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: widget.themeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(widget.icon, size: 18, color: widget.themeColor),
              ),
            ),
            const SizedBox(width: 12), // Horizontal spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                      letterSpacing: -0.2,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.desc,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11, // Smaller font for description
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: (50 * widget.index).ms).scale(begin: const Offset(0.95, 0.95)),
    );
  }
}
