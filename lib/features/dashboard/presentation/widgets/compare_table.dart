import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CompareTable extends StatelessWidget {
  const CompareTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          _buildComparisonRow('Monthly Premium', '₹2,450', '₹3,120', isHighlight: true),
          _buildComparisonRow('Sum Insured', '₹10 Lakhs', '₹15 Lakhs'),
          _buildComparisonRow('Room Rent Limit', 'No Limit', 'Single Private'),
          _buildComparisonRow('No Claim Bonus', '10% Per Year', '25% Per Year'),
          _buildComparisonRow('Pre-Post Hosp.', '60/90 Days', '90/180 Days'),
          _buildComparisonRow('Annual Checkup', 'Included', 'Included'),
          const SizedBox(height: 24),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          const Expanded(flex: 2, child: SizedBox()),
          Expanded(
            flex: 3,
            child: Text(
              'HDFC Ergo Optima',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Star Health Premier',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String label, String v1, String v2, {bool isHighlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        color: isHighlight ? Colors.blue.shade50.withValues(alpha: 0.3) : null,
        border: Border(bottom: BorderSide(color: Colors.grey.shade50)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              v1,
              style: GoogleFonts.inter(
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
                color: isHighlight ? Colors.blue.shade900 : Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              v2,
              style: GoogleFonts.inter(
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
                color: isHighlight ? Colors.blue.shade900 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
