import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HDFC Insurance Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // --- COLORS ---
        // Using HDFC-style Navy Blue as primary
        primaryColor: const Color(0xFF003366),
        // A soft grey-blue background makes white cards pop
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003366),
          primary: const Color(0xFF003366), // Navy
          secondary: const Color(0xFFE31E24), // Red Accent
          surface: Colors.white,
        ),
        
        useMaterial3: true,

        // --- TYPOGRAPHY ---
        fontFamily: 'Roboto', // Or your preferred font
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 28, 
            fontWeight: FontWeight.bold, 
            color: Color(0xFF003366)
          ),
          titleLarge: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.w700, 
            color: Color(0xFF1A1A1A)
          ),
          bodyMedium: TextStyle(
            fontSize: 14, 
            color: Color(0xFF4A4A4A)
          ),
        ),

        // --- INPUT FIELDS (Login Page will inherit this) ---
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          // Default border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          // Border when not clicked
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          // Border when clicked (Active)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF003366), width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
        ),

        // --- BUTTONS (Login Page will inherit this) ---
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF003366),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            shadowColor: const Color(0xFF003366).withOpacity(0.4),
            textStyle: const TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      // Points exactly where you wanted
      home: const LoginPage(),
    );
  }
}