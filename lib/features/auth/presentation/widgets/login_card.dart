import 'package:flutter/material.dart';

import '../controller/auth_controller.dart';
import 'brand_panel.dart';
import 'form_panel.dart';
import 'hdfc_logo.dart';

class LoginCard extends StatelessWidget {
  final AuthController controller;
  final VoidCallback onLoginSuccess;

  const LoginCard({
    super.key,
    required this.controller,
    required this.onLoginSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;

        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left brand panel
                if (!isMobile)
                  const Expanded(
                    flex: 9,
                    child: BrandPanel(),
                  ),

                // Mobile header
                if (isMobile)
                  Container(
                    padding: const EdgeInsets.all(24),
                    color: const Color(0xFF003366),
                    child: const HdfcLogo(),
                  ),

                // Right form panel
                Expanded(
                  flex: 11,
                  child: FormPanel(
                    controller: controller,
                    onLoginSuccess: onLoginSuccess,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
