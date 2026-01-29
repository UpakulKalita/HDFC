import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:math' as math;

// Define Colors locally if needed, but reusing AppColors is best.
// Assuming AppColors is available via import or context.
// For self-containment, I'll use standard colors that match the theme.

class UserProfileInsightCard extends StatelessWidget {
  const UserProfileInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16), // Reduced from 20
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF1F2), 
            Color(0xFFF0F9FF),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFFDBA74), // Orange dot
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Insurance Score:",
                style: TextStyle(
                  fontSize: 13, // Slight reduction
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
            ],
          ),

          const SizedBox(height: 8), // Reduced from 12

          // Main Content: Score + Gauge
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Score Text
              const Text(
                "72%",
                style: TextStyle(
                  fontSize: 32, // Reduced from 36
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B), // Slate 800
                  height: 1,
                ),
              ),
              
              const Spacer(),
              
              // Gauge Chart
              SizedBox(
                width: 70, // Slight reduction width
                height: 44, // Reduced height
                child: CustomPaint(
                  painter: _GaugePainter(),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Container(
                         padding: const EdgeInsets.all(2),
                         decoration: const BoxDecoration(
                           color: Colors.white,
                           shape: BoxShape.circle,
                           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]
                         ),
                         child: const Icon(LucideIcons.arrowDown, size: 12, color: Color(0xFF10B981)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12), // Reduced from 16

          // Message
          const Text(
            "Coverage Gap:",
             style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 2),
           Text(
            "Health Insurance Missing",
             style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),

          const SizedBox(height: 12), // Reduced from 16

          // Button
          SizedBox(
            width: double.infinity,
            height: 36, // Reduced from 40
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB), // Blue 600
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: const Text("Check Coverage", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define Center and Radius
    final center = Offset(size.width / 2, size.height);
    final radius = math.min(size.width, size.height * 2);

    final paintBg = Paint()
      ..color = const Color(0xFFE2E8F0) // Slate 200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final paintProgress = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
      
      // Gradient for progress
      final rect = Rect.fromCircle(center: center, radius: radius);
      paintProgress.shader = const LinearGradient(
        colors: [
           Color(0xFF60A5FA), // Blue
           Color(0xFF34D399), // Green
           Color(0xFFFBBF24), // Amber
        ],
      ).createShader(rect);

    // Draw Background Arc (180 degrees)
    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width, height: size.height * 2),
      math.pi, // Start at 180 (left)
      math.pi, // Sweep 180 (to right)
      false,
      paintBg,
    );
    
    // Draw Progress Arc (72% of 180 degrees)
    // 72% -> 0.72 * PI
    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width, height: size.height * 2),
      math.pi, 
      math.pi * 0.72, 
      false,
      paintProgress,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
