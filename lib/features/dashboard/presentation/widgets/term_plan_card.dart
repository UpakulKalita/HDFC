import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:lucide_icons/lucide_icons.dart';

class TermPlanCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String coverage;
  final String claimRatio;
  final String term;
  final String waitingPeriod;
  final List<String> features;
  final List<String> tags;
  final bool isPopular;

  const TermPlanCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.coverage,
    required this.claimRatio,
    required this.term,
    required this.waitingPeriod,
    required this.features,
    required this.tags,
    required this.isPopular,
  });

  @override
  State<TermPlanCard> createState() => _TermPlanCardState();
}

class _TermPlanCardState extends State<TermPlanCard> with AutomaticKeepAliveClientMixin {
  bool _isHovered = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const primaryColor = Color(0xFF1565C0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: _isHovered ? Matrix4.identity().scaled(1.02, 1.02, 1.0) : Matrix4.identity(),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: widget.isPopular
                ? primaryColor.withValues(alpha: 0.5)
                : (_isHovered ? primaryColor.withValues(alpha: 0.3) : Colors.grey.shade200),
            width: widget.isPopular ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isPopular
                  ? primaryColor.withValues(alpha: _isHovered ? 0.2 : 0.1)
                  : Colors.black.withValues(alpha: _isHovered ? 0.1 : 0.06),
              blurRadius: _isHovered ? 24 : 20,
              offset: Offset(0, _isHovered ? 12 : 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.4),
                      ],
                    ),
                  ),
                ),
                if (widget.isPopular)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            'Recommended',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.tags.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      children: widget.tags.map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.inter(
                            color: Colors.grey.shade600,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 12),
                  ],
                  Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildStatTile('Coverage', widget.coverage, Icons.shield_outlined, primaryColor)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatTile('Term', widget.term, LucideIcons.calendar, primaryColor)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildStatTile('Claims', widget.claimRatio, Icons.verified_user_outlined, primaryColor)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),
                  Text(
                    'Why Recommended',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: widget.features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.price,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'billed annually',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: Colors.grey.shade500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.isPopular ? primaryColor : Colors.black,
                        foregroundColor: Colors.white,
                        elevation: widget.isPopular ? 8 : 0,
                        shadowColor: widget.isPopular ? primaryColor.withValues(alpha: 0.4) : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'View Plan',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(String label, String value, IconData icon, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: primaryColor.withValues(alpha: 0.7)),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF1E293B),
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
