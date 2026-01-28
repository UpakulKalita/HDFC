import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';

class ModernField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final Function(String)? onChanged;

  const ModernField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 18, color: AppColors.primary.withValues(alpha: 0.5)),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            ),
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}
