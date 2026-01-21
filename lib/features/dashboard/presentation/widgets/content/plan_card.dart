import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/core/constants/app_colors.dart';

class PlanCard extends StatefulWidget {
  final String title;
  final String category;
  final String amount;
  final String price;
  final Color color;
  final IconData iconData;

  const PlanCard({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.price,
    required this.color,
    required this.iconData,
  });

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: AppColors.durationShort,
        curve: Curves.easeOutCubic,
        transform: _isHovering ? Matrix4.identity().scaled(1.02) : Matrix4.identity(),
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // Reduced from 28
          border: Border.all(
            color: _isHovering ? widget.color.withOpacity(0.5) : Colors.grey.withOpacity(0.1),
            width: _isHovering ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovering ? widget.color.withOpacity(0.15) : Colors.black.withOpacity(0.08),
              blurRadius: _isHovering ? 30 : 24,
              offset: _isHovering ? const Offset(0, 15) : const Offset(0, 12),
            ),
            if (_isHovering)
              BoxShadow(
                color: widget.color.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // --- DECORATIVE BACKGROUND ACCENT ---
            // Animated pulsing circle on hover would be nice, simply scaling it here
            AnimatedPositioned(
              duration: AppColors.durationMedium,
              curve: Curves.easeOutBack,
              right: _isHovering ? -20 : -30,
              top: _isHovering ? -20 : -30,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withOpacity(0.08),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- TOP: Category & Icon ---
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: AppColors.durationShort,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _isHovering ? widget.color : widget.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          widget.iconData,
                          color: _isHovering ? Colors.white : widget.color,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // --- MIDDLE: Title & Coverage ---
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(LucideIcons.checkCircle, size: 16, color: widget.color),
                      const SizedBox(width: 6),
                      Text(
                        widget.amount,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Divider(height: 1, color: Colors.grey.withOpacity(0.2)),

                  const SizedBox(height: 20),

                  // --- BOTTOM: Price & Button ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Starting from",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.price,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Action Button
                      AnimatedContainer(
                        duration: AppColors.durationShort,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: widget.color.withOpacity(0.4),
                              blurRadius: _isHovering ? 15 : 10,
                              offset: _isHovering ? const Offset(0, 6) : const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "View Plan",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            AnimatedContainer(
                              duration: AppColors.durationShort,
                              width: _isHovering ? 5 : 0,
                            ),
                            if (_isHovering)
                              const Icon(LucideIcons.arrowRight, color: Colors.white, size: 16)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}