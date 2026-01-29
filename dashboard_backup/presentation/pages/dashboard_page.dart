import 'package:flutter/material.dart';

import '../widgets/layout/dashboard_layout.dart';
import '../widgets/content/dashboard_home_content.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardLayout(
      child: DashboardHomeContent(),
    );
  }
}
