import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/settings_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';

void main() {
  runApp(const InsuranceApp());
}

class InsuranceApp extends StatelessWidget {
  const InsuranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HDFC Insurance Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF004C8F)),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const LoginPage(),
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/health-plans': (context) => const HealthPlansPage(),
        '/term-plans': (context) => const TermPlansPage(),
        '/life-insurance': (context) => const LifeInsurancePage(),
        '/get-help': (context) => const GetHelpPage(),
        '/settings': (context) => const SettingsPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
