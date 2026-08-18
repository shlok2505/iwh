import 'package:flutter/material.dart';
import '../models/footprint.dart';
import '../screens/detailFp.dart';

class FootprintCard extends StatelessWidget {
  final Footprint footprint;
  final VoidCallback? onTap;
  final bool isCompact;

  const FootprintCard({
    super.key,
    required this.footprint,
    this.onTap,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FootprintDetail(footprint: footprint),
              ),
            );
          },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HERO IMAGE + OVERLAYS
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: isCompact ? 1.4 : 1.25,
                    child: Image.network(
                      footprint.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFE2E8F0),
                          child: const Center(
                            child: Icon(
                              Icons.landscape_rounded,
                              size: 36,
                              color: Colors.black38,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // PUBLIC / PRIVATE PILL
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            footprint.isPublic
                                ? Icons.public
                                : Icons.lock_outline,
                            size: 13,
                            color: Colors.white,
                          ),
                          if (footprint.photoCount > 0) ...[
                            const SizedBox(width: 4),
                            Text(
                              '${footprint.photoCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // COMPANIONS CHIP
                  if (footprint.companions.isNotEmpty)
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.group_outlined,
                              size: 12,
                              color: Colors.black87,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '+${footprint.companions.length}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              // CARD BODY
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PLACE NAME
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 15,
                          color: Color(0xFFE53E3E),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            footprint.place,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3748),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // DATE & TIME
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: Colors.black45,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          footprint.date,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          footprint.time,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),

                    if (footprint.highlights.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: footprint.highlights.take(2).map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDF2F7),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '#$tag',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF4A5568),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
