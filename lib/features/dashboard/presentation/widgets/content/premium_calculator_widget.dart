import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AppColors {
  static const Color navyBlue = Color(0xFF1E3A8A);
  static const Color textGrey = Color(0xFF64748B);
  static const Color textDark = Color(0xFF0F172A);
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color lightBg = Color(0xFFF6F8FF);
}

class PremiumCalculatorWidget extends StatefulWidget {
  const PremiumCalculatorWidget({super.key});

  @override
  State<PremiumCalculatorWidget> createState() => _PremiumCalculatorWidgetState();
}

class _PremiumCalculatorWidgetState extends State<PremiumCalculatorWidget> {
  int _age = 60;
  String _income = "₹ 10L";
  int _estimatedPremium = 600;

  void _calculatePremium() {
    setState(() {
      _estimatedPremium = _age * 15;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24), // Add bottom spacing between panels
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEFF6FF), // Blue 50
            Color(0xFFDBEAFE), // Blue 100
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // --- ROW 1: Header (Icon + Title + Price) ---
          Row(
            children: [
              const Icon(LucideIcons.calculator, size: 20, color: AppColors.navyBlue),
              const SizedBox(width: 8),
              const Text(
                "Premium Calculator",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navyBlue,
                ),
              ),
              const Spacer(),
              Text(
                "₹$_estimatedPremium/mo",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- ROW 2: Inputs + Button ---
          Row(
            children: [
              // Age Input
              Expanded(
                flex: 2,
                child: _buildInputBox(label: "Age", value: "$_age"),
              ),
              const SizedBox(width: 12),
              
              // Income Input
              Expanded(
                flex: 3,
                child: _buildInputBox(label: "Income", value: _income),
              ),
              const SizedBox(width: 12),
              
              // View Button
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 44, // Match input height for alignment
                  child: ElevatedButton(
                    onPressed: _calculatePremium,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "View", // Short text to fit if needed, or "View Plans"
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox({required String label, required String value}) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent), // No border for cleaner look
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 9, color: AppColors.textGrey, height: 1)),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark, height: 1.2)),
            ],
          ),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textGrey),
        ],
      ),
    );
  }
}
