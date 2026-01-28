import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD


import 'package:insurance_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/health_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/term_plans_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/life_insurance_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/get_help_page.dart';
import 'package:insurance_flutter/features/dashboard/presentation/pages/profile_page.dart';

import 'package:provider/provider.dart';
import 'package:insurance_flutter/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:insurance_flutter/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:insurance_flutter/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:insurance_flutter/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:insurance_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:insurance_flutter/features/auth/presentation/providers/auth_provider.dart';
=======
import 'package:provider/provider.dart';
import 'package:insurance_flutter/features/auth/presentation/controller/auth_controller.dart';
import 'package:insurance_flutter/features/auth/presentation/pages/login_page.dart';
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272

void main() {
  runApp(const InsuranceApp());
}

class InsuranceApp extends StatelessWidget {
  const InsuranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
<<<<<<< HEAD
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(
            repository: DashboardRepositoryImpl(
              localDataSource: DashboardLocalDataSourceImpl(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            repository: AuthRepositoryImpl(
              localDataSource: AuthLocalDataSourceImpl(),
            ),
          ),
        ),
=======
        ChangeNotifierProvider(create: (_) => AuthController()),
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
      ],
      child: MaterialApp(
        title: 'HDFC Insurance Portal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF004C8F)),
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme(),
        ),
<<<<<<< HEAD
        home: const DashboardPage(),
        routes: {
          '/dashboard': (context) => const DashboardPage(),
          '/health-plans': (context) => const HealthPlansPage(),
          '/term-plans': (context) => const TermPlansPage(),
          '/life-insurance': (context) => const LifeInsurancePage(),
          '/get-help': (context) => const GetHelpPage(),
          '/profile': (context) => const ProfilePage(),
        },
=======
        home: const LoginPage(),
>>>>>>> 439ddb8cea7c8238ea1b458e68168840ccc34272
      ),
    );
  }
}
