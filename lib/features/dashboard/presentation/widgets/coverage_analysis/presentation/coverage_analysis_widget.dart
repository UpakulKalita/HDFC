import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_flutter/features/dashboard/domain/entities/dashboard_metric.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import flutter_animate

class CoverageAnalysisWidget extends StatelessWidget {
  final List<DashboardMetric> metrics;

  const CoverageAnalysisWidget({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate overall score based on total coverage / total target
    double totalCurrent = 0.0;
    double totalTarget = 0.0;
    
    for (var metric in metrics) {
      if (metric.currentCoverage != null && metric.targetCoverage != null) {
        totalCurrent += _parseCurrencyValue(metric.currentCoverage!);
        totalTarget += _parseCurrencyValue(metric.targetCoverage!);
      }
    }

    double percent = 0.0;
    if (totalTarget > 0) {
      percent = (totalCurrent / totalTarget);
    }
    
    // Cap at 120% for visual purposes only, but logic will use real percent
    final int overallScore = (percent * 100).round();

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
                  'Coverage Analysis',
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
                      
                      // Add spacing between items
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: index == 0 ? 12.0 : 0),
                          child: _buildVerticalMetricCard(
                            metric,
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
               child: TweenAnimationBuilder<double>(
                 key: ValueKey(overallScore), // Force restart animation when score changes
                 tween: Tween<double>(begin: 0, end: overallScore.toDouble()),
                 duration: const Duration(milliseconds: 2000), 
                 curve: Curves.easeOutBack,
                 builder: (context, value, _) {
                   return Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                       CustomPaint(
                         size: const Size(160, 80), 
                         painter: ReferenceGradientGaugePainter(score: value.clamp(0.0, 100.0)),
                       ),
                      // Score Text
                      Positioned(
                        bottom: -5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${value.round()}%', // Show actual animated score
                              style: GoogleFonts.outfit(
                                fontSize: 30, // Slightly smaller to fit compact height
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0F172A),
                                height: 1.0,
                              ),
                            ),
                            Text(
                              _getStatusText(overallScore), // Keep status based on final target? Or value? Let's use final for stability
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(overallScore),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                 }
               ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to parse '₹50L', '₹1Cr' -> raw double value
  double _parseCurrencyValue(String value) {
    if (value.isEmpty) return 0.0;
    
    // Remove currency symbol and spaces
    String cleaned = value.replaceAll('₹', '').replaceAll(',', '').trim();
    double multiplier = 1.0;

    if (cleaned.toLowerCase().endsWith('l')) {
      multiplier = 100000;
      cleaned = cleaned.substring(0, cleaned.length - 1);
    } else if (cleaned.toLowerCase().endsWith('cr')) {
      multiplier = 10000000;
      cleaned = cleaned.substring(0, cleaned.length - 2);
    } else if (cleaned.toLowerCase().endsWith('k')) {
      multiplier = 1000;
      cleaned = cleaned.substring(0, cleaned.length - 1);
    }

    try {
      return double.parse(cleaned) * multiplier;
    } catch (e) {
      return 0.0;
    }
  }

  String _getStatusText(int score) {
    if (score < 90) return 'Underinsured';
    if (score <= 100) return 'Adequate';
    return 'Overinsured';
  }

  Color _getStatusColor(int score) {
    if (score < 90) return const Color(0xFFEF4444); // Red
    if (score <= 100) return const Color(0xFF10B981); // Emerald
    return const Color(0xFF3B82F6); // Blue for Overinsured? Or maintain Emerald? Let's go blue/info.
  }

  Widget _buildVerticalMetricCard(DashboardMetric metric) {
    final isGood = metric.status == 'Good';
    final statusColor = isGood ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final iconColor = isGood ? const Color(0xFF047857) : const Color(0xFFB91C1C);
    final bgIcon = isGood ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2);
    
    // Life -> heart, Term Life (or others) -> shield
    final IconData icon = metric.label == 'Life' ? Icons.favorite_rounded : Icons.shield_rounded;

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  metric.label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 4),
                if (metric.currentCoverage != null && metric.targetCoverage != null) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        metric.currentCoverage!,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        ' / ${metric.targetCoverage!}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF94A3B8),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),

                ] else
                  Text(
                    metric.value,
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

    // Dynamic Gradient from Red to Emerald to Green
    const colors = [
      Color(0xFFEF4444), // Red
      Color(0xFFF59E0B), // Amber/Orange
      Color(0xFF10B981), // Emerald
      Color(0xFF047857), // Dark Green
    ];
    
    // Create stops to distribute colors evenly or skewed towards high scores
    const stops = [0.0, 0.5, 0.8, 1.0];

    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle, // Gradient covers full sweep for consistent color mapping
      colors: colors,
      stops: stops,
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
