import 'package:flutter/material.dart';
import '/../core/constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "© 2026 HDFC Bank Ltd. All rights reserved.",
        style: TextStyle(
          color: AppColors.textGrey,
          fontSize: 12,
        ),
      ),
    );
  }
}
