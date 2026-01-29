import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:insurance_flutter/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final bool hasEye;
  final bool hasError;
  final VoidCallback? onEyeTap;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    required this.hint,
    this.isPassword = false,
    this.hasEye = false,
    this.hasError = false,
    this.onEyeTap,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Always show Label
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ),

        Stack(
          children: [
            SizedBox(
              height: 48,
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(left: 44, right: 48),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: hasError ? Colors.red : Colors.grey.shade200, width: hasError ? 2 : 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: hasError ? Colors.red : Colors.grey.shade200, width: hasError ? 2 : 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: hasError ? Colors.red : AppColors.primary, width: 2),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 14,
              child: Icon(icon, color: Colors.grey.shade400, size: 20),
            ),
            if (hasEye)
              Positioned(
                right: 12,
                top: 12,
                child: GestureDetector(
                  onTap: onEyeTap,
                  child: Icon(
                    isPassword ? LucideIcons.eye : LucideIcons.eyeOff,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
        
        // Show Error below input if exists
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              errorText!,
              style: GoogleFonts.inter(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }
}
