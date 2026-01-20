import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Prevent instantiation

  // ===========================
  // ANIMATION DURATIONS
  // ===========================
  static const Duration durationShort = Duration(milliseconds: 200);
  static const Duration durationMedium = Duration(milliseconds: 400);
  static const Duration durationLong = Duration(milliseconds: 800);

  // ===========================
  // BRAND IDENTITY (Premium FinTech)
  // ===========================
  // A richer, deeper Navy for the "Trust" factor
  static const Color navyBlue = Color(0xFF0F2642); 
  
  // A vibrant Royal Blue for Primary Actions (Buttons/Links)
  static const Color primaryBlue = Color(0xFF2563EB); 
  
  // Hover state for primary blue
  static const Color primaryDark = Color(0xFF1E40AF); 
  
  // A subtle Gold/Amber for "Premium" tags or plans
  static const Color accentGold = Color(0xFFF59E0B); 

  // ===========================
  // GRADIENTS (For Cards & Sidebar)
  // ===========================
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0F2642), Color(0xFF1E3A8A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient hoverGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF1F5F9)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ===========================
  // NEUTRALS & BACKGROUNDS
  // ===========================
  // Cool-toned white for main background (Modern Feel)
  static const Color background = Color(0xFFF1F5F9); 
  
  // Pure white for cards
  static const Color surface = Colors.white; 
  
  // Slightly off-white for headers/sidebars
  static const Color surfaceAlt = Color(0xFFF8FAFC); 

  // ===========================
  // TEXT COLORS (Typography)
  // ===========================
  // Very Dark Blue-Grey (Softer than pure black)
  static const Color textDark = Color(0xFF1E293B); 
  
  // Medium Body Text
  static const Color textGrey = Color(0xFF64748B); 
  
  // Hints / Placeholders
  static const Color textLight = Color(0xFF94A3B8); 

  // ===========================
  // BORDERS & DIVIDERS
  // ===========================
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);

  // ===========================
  // FUNCTIONAL STATUS (With Tints)
  // ===========================
  // Success
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5); // For badges

  // Warning
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7); // For badges

  // Error
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2); // For badges

  // Info
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE); // For badges

  // ===========================
  // EFFECTS
  // ===========================
  static Color shadow = const Color(0xFF0F172A).withOpacity(0.08);
  static Color shadowDark = const Color(0xFF0F172A).withOpacity(0.15);
}