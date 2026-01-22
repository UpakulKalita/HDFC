import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoHeader extends StatelessWidget {
  final String logoPath;
  final double logoHeight;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;

  const LogoHeader({
    super.key,
    this.logoPath = 'assets/logo.webp',
    this.logoHeight = 32,
    this.title = 'HDFC BANK',
    this.subtitle = 'Insurance Portal',
    this.titleColor = Colors.white,
    this.subtitleColor = const Color(0xFFBBDEFB), // Blue 100 approx
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            logoPath,
            height: logoHeight,
            width: logoHeight,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                color: subtitleColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
