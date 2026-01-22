import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final List<Color> gradientColors;
  final List<Color> disabledColors;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.gradientColors = const [AppColors.gradientStart, AppColors.gradientEnd],
    this.disabledColors = const [Colors.grey, Color(0xFF616161)], // grey[700] approx
  });

  @override
  Widget build(BuildContext context) {
    final bool isActuallyDisabled = isDisabled || isLoading || onPressed == null;

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: isActuallyDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isActuallyDisabled ? disabledColors : gradientColors,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              if (!isActuallyDisabled)
                const BoxShadow(
                  color: Color.fromRGBO(0, 76, 143, 0.5),
                  offset: Offset(0, 10),
                  blurRadius: 25,
                  spreadRadius: -5,
                )
            ],
          ),
          child: Container(
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
