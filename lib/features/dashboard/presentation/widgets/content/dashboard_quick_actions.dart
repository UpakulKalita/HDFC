import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../../../core/constants/app_colors.dart';

class QuickActionsPanel extends StatelessWidget {
  const QuickActionsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        
        // Grid Layout: 2 Rows of 3 Items
        Column(
          children: [
            // Row 1
            Row(
              children: const [
                Expanded(child: ActionSquare(icon: LucideIcons.filePlus, label: "Raise Claim", color: Colors.pink)),
                SizedBox(width: 12),
                Expanded(child: ActionSquare(icon: LucideIcons.refreshCw, label: "Renew Policy", color: Colors.green)),
                SizedBox(width: 12),
                Expanded(child: ActionSquare(icon: LucideIcons.download, label: "Download", color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 12),
            // Row 2
            Row(
              children: const [
                Expanded(child: ActionSquare(icon: LucideIcons.scale, label: "Compare", color: Colors.purple)),
                SizedBox(width: 12),
                Expanded(child: ActionSquare(icon: LucideIcons.calculator, label: "Calculator", color: Colors.orange)),
                SizedBox(width: 12),
                Expanded(child: ActionSquare(icon: LucideIcons.shieldCheck, label: "Check Cover", color: Colors.teal)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ActionSquare extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;

  const ActionSquare({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  State<ActionSquare> createState() => _ActionSquareState();
}

class _ActionSquareState extends State<ActionSquare> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 85, // Fixed square-ish height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovering ? widget.color.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovering ? widget.color.withOpacity(0.15) : Colors.black.withOpacity(0.02),
                blurRadius: _isHovering ? 12 : 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  size: 20,
                  color: widget.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                maxLines: 1, // Ensure single line
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
