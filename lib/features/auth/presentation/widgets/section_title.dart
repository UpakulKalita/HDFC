import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color titleColor;
  final Color subtitleColor;
  final double titleFontSize;
  final double subtitleFontSize;
  final CrossAxisAlignment crossAxisAlignment;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.titleColor = AppColors.textDark,
    this.subtitleColor = AppColors.textGrey,
    this.titleFontSize = 28,
    this.subtitleFontSize = 13,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4), 
          Text(
            subtitle!,
            style: GoogleFonts.inter(
              color: subtitleColor,
              fontSize: subtitleFontSize,
            ),
          ),
        ]
      ],
    );
  }
}
