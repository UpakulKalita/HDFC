import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:insurance_flutter/features/auth/presentation/controller/auth_controller.dart';
import 'package:insurance_flutter/features/auth/presentation/pages/login_page.dart';

import 'package:insurance_flutter/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:insurance_flutter/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:insurance_flutter/features/dashboard/presentation/providers/dashboard_provider.dart';

void main() {
  runApp(const InsuranceApp());
}

class InsuranceApp extends StatelessWidget {
  const InsuranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => DashboardProvider(
          repository: DashboardRepositoryImpl(localDataSource: DashboardLocalDataSourceImpl()),
        )),
      ],
      child: MaterialApp(
        title: 'HDFC Insurance Portal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF004C8F)),
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme(),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
