import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HdfcLogo extends StatelessWidget {
  const HdfcLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(6),
          child: Image.asset(
            'assets/images/hdfc_logo.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "HDFC BANK",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            Text(
              "Insurance Portal",
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.blueAccent.shade100,
                letterSpacing: 0.5,
              ),
            ),
          ],
        )
      ],
    );
  }
}
