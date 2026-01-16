import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BlurBlob extends StatelessWidget {
  final double size;
  final Color color;

  const BlurBlob({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    )
    .animate(onPlay: (controller) => controller.repeat(reverse: true))
    .scaleXY(begin: 1.0, end: 1.1, duration: 4.seconds, curve: Curves.easeInOut);
  }
}
