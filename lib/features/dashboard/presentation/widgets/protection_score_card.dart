import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/features/dashboard/domain/entities/dashboard_metric.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate

class ProtectionScoreCard extends StatelessWidget {
  final List<DashboardMetric> metrics;

  const ProtectionScoreCard({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate overall score (using same logic/mock data assumptions)
    double avgProgress = 0.0;
    if (metrics.isNotEmpty) {
      avgProgress = metrics.fold(0.0, (sum, item) => sum + item.progress) / metrics.length;
    }
    final int overallScore = (avgProgress * 100).round();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24), // Slightly tighter radius
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFF8FAFC),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64748B).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LEFT SIDE: Header & Metrics Row
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header (No Icon)
                Text(
                  'Coverage Health',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16), // Reduced spacing
                
                // Metrics in a SINGLE ROW
                if (metrics.isNotEmpty)
                  Row(
                    children: metrics.take(2).toList().asMap().entries.map((entry) {
                      final index = entry.key;
                      final metric = entry.value;
                      final isGood = metric.status == 'Good';
                      
                      // Add spacing between items
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: index == 0 ? 12.0 : 0),
                          child: _buildVerticalMetricCard(
                            metric.label,
                            metric.value,
                            isGood,
                          ).animate()
                           .fadeIn(delay: (200 * index).ms)
                           .slideY(begin: 0.2, curve: Curves.easeOut),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),

          // RIGHT SIDE: Gauge (Centered Vertically)
          Expanded(
            flex: 4,
            child: Container(
               height: 100, // Reduced height constraint
               alignment: Alignment.center, // Center the stack within this height
               child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                   TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: overallScore.toDouble()),
                    duration: const Duration(milliseconds: 1800),
                    curve: Curves.easeOutBack,
                    builder: (context, value, _) {
                      return CustomPaint(
                        size: const Size(160, 80), 
                        painter: ReferenceGradientGaugePainter(score: value),
                      );
                    }
                  ),
                  // Score Text
                  Positioned(
                    bottom: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          overallScore.toString(),
                          style: GoogleFonts.outfit(
                            fontSize: 30, // Slightly smaller to fit compact height
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                            height: 1.0,
                          ),
                        ),
                        Text(
                          overallScore >= 70 ? 'Excellent' : 'Average',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: overallScore >= 70 ? const Color(0xFF10B981) : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 600.ms),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalMetricCard(String title, String value, bool isGood) {
    final statusColor = isGood ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final iconColor = isGood ? const Color(0xFF047857) : const Color(0xFFB91C1C);
    final bgIcon = isGood ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2);
    
    // Life -> heart, Term Life (or others) -> shield
    final IconData icon = title == 'Life' ? Icons.favorite_rounded : Icons.shield_rounded;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.08),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgIcon,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                    letterSpacing: 0.1,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.2,
                  ),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // Old method kept for interface compatibility if needed, but unused
  Widget _buildCompactMetricCard(String title, String value, bool isGood) {
      return const SizedBox.shrink();
  }
}

class ReferenceGradientGaugePainter extends CustomPainter {
  final double score;

  ReferenceGradientGaugePainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    // 180 degree gauge
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    
    const startAngle = math.pi;
    const sweepAngle = math.pi;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // 1. Ticks (Outside)
    // Matches image: small ticks around the top
    final tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.grey.shade300; // Light grey ticks

    final rTicksInner = radius;
    final rTicksOuter = radius + 8; // Ticks extend outwards
    final int tickCount = 30;
    
    for (int i = 0; i <= tickCount; i++) {
       final percent = i / tickCount;
       final angle = startAngle + (percent * sweepAngle);
       
       // Major ticks longer? Image looks mostly uniform, maybe slightly thicker for some
       final isMajor = i % 5 == 0;
       final tickLen = isMajor ? 10.0 : 6.0;
       
       final p1 = Offset(center.dx + math.cos(angle) * rTicksInner, center.dy + math.sin(angle) * rTicksInner);
       final p2 = Offset(center.dx + math.cos(angle) * (rTicksInner + tickLen), center.dy + math.sin(angle) * (rTicksInner + tickLen));
       
       tickPaint.color = isMajor ? Colors.grey.shade400 : Colors.grey.shade300;
       tickPaint.strokeWidth = isMajor ? 2.5 : 1.5;
       canvas.drawLine(p1, p2, tickPaint);
    }

    // 2. Track Background (Faint Arc)
    // Image has a very faint grey track where the gradient isn't filling
    // It's inside the ticks.
    final trackRadius = radius - 15;
    
    paint.strokeWidth = 16;
    paint.color = const Color(0xFFF1F5F9); // Very light grey
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: trackRadius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    // 3. Gradient Progress Arc
    final progressAngle = (score / 100).clamp(0.0, 1.0) * sweepAngle;

    // Green Gradient (Light Green -> Dark Green) matching "72 Excellent"
    const colors = [
      Color(0xFF86EFAC), // Light Green
      Color(0xFF10B981), // Emerald
      Color(0xFF047857), // Dark Green
    ];

    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle, // Gradient covers full sweep for consistent color mapping
      colors: colors,
      tileMode: TileMode.clamp,
    ).createShader(Rect.fromCircle(center: center, radius: trackRadius));

    paint.shader = gradient;
    paint.strokeWidth = 16;
    paint.strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: trackRadius),
      startAngle,
      progressAngle,
      false,
      paint,
    );

    // 4. White Knob at the end
    final knobAngle = startAngle + progressAngle;
    final knobCenter = Offset(
      center.dx + math.cos(knobAngle) * trackRadius,
      center.dy + math.sin(knobAngle) * trackRadius,
    );
    
    // Knob Border (Greenish)
    canvas.drawCircle(knobCenter, 8, Paint()..color = const Color(0xFF047857));
    
    // Knob Body (White)
    canvas.drawCircle(knobCenter, 5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
