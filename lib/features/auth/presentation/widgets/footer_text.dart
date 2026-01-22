import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';

class FooterText extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? color;
  final double fontSize;
  final Alignment alignment;

  const FooterText({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.fontSize = 13,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Text(
      text,
      style: GoogleFonts.inter(
        color: color ?? AppColors.primary,
        fontSize: fontSize,
      ),
    );

    if (onTap != null) {
      textWidget = GestureDetector(
        onTap: onTap,
        child: textWidget,
      );
    }

    return Container(
      alignment: alignment,
      child: textWidget,
    );
  }
}
