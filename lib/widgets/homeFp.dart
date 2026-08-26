import 'package:flutter/material.dart';
import 'package:iwh/data/footprint.dart';
import 'package:iwh/models/presence.dart';
import 'package:iwh/widgets/feedPresence.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  bool friendsOnly = false;

  List<Footprint> get _visibleFootprints {
    final publicFootprints = footprints.where((fp) => !fp.isMemory).toList();
    if (!friendsOnly) return publicFootprints;
    return publicFootprints.where((fp) => fp.isFriend).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _visibleFootprints;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 210),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Social Feed',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2F3E3A),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.people_alt_outlined,
                        size: 20,
                        color: Color(0xFF3D5A40),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'See where others are exploring.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7C74),
                    ),
                  ),
                ],
              ),
            ),
            _FilterChip(
              label: friendsOnly ? 'Friends' : 'All',
              onTap: () {
                setState(() {
                  friendsOnly = !friendsOnly;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (items.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 48),
            child: Center(
              child: Text(
                'No footprints to show yet.',
                style: TextStyle(color: Color(0xFF6B7C74)),
              ),
            ),
          )
        else
          ...List.generate(items.length, (index) {
            return FeedFootprintCard(
              footprint: items[index],
              variant: index,
            );
          }),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F6EF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFD7DDD4)),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3D5A40),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: Color(0xFF3D5A40),
            ),
          ],
        ),
      ),
    );
  }
}
