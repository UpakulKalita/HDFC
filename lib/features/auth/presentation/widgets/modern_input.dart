import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;

  const ModernInput({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: Colors.grey[500]),
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF003366),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
