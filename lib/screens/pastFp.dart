import 'package:flutter/material.dart';

import '../../data/footprint.dart';
import '../../models/footprint.dart';
import 'detailFp.dart';

class PastFp extends StatelessWidget {
  const PastFp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5EF),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Past Footprints',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              'Your memories, your journey.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),

        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: GridView.builder(
          itemCount: footprints.length,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.70,
          ),

          itemBuilder: (context, index) {
            final Footprint footprint = footprints[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FootprintDetail(footprint: footprint),
                  ),
                );
              },

              child: _FootprintCard(footprint: footprint),
            );
          },
        ),
      ),
    );
  }
}

class _FootprintCard extends StatelessWidget {
  final Footprint footprint;

  const _FootprintCard({required this.footprint});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.25,

                  child: Image.network(
                    footprint.image,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image_not_supported, size: 40),
                      );
                    },
                  ),
                ),

                // PUBLIC / PRIVATE
                Positioned(
                  top: 8,
                  right: 8,

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 5,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Icon(
                      footprint.isPublic ? Icons.public : Icons.lock_outline,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),

            // INFORMATION
            Padding(
              padding: const EdgeInsets.all(10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PLACE
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 17),

                      const SizedBox(width: 4),

                      Expanded(
                        child: Text(
                          footprint.place,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  // DATE
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 14),

                      const SizedBox(width: 5),

                      Text(
                        footprint.date,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // TIME
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14),

                      const SizedBox(width: 5),

                      Text(
                        footprint.time,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 9),

                  // MEDIA COUNTS
                  Row(
                    children: [
                      _MediaCount(
                        icon: Icons.image_outlined,
                        count: footprint.photoCount,
                      ),

                      const SizedBox(width: 10),

                      _MediaCount(
                        icon: Icons.videocam_outlined,
                        count: footprint.videoCount,
                      ),

                      const SizedBox(width: 10),

                      _MediaCount(
                        icon: Icons.mic_none,
                        count: footprint.audioCount,
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

class _MediaCount extends StatelessWidget {
  final IconData icon;
  final int count;

  const _MediaCount({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: Colors.black54),

        const SizedBox(width: 3),

        Text(
          '$count',
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }
}
