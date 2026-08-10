import 'package:flutter/material.dart';

import '../../models/footprint.dart';

class FootprintDetail extends StatelessWidget {
  final Footprint footprint;

  const FootprintDetail({super.key, required this.footprint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),

      body: CustomScrollView(
        slivers: [
          // HERO IMAGE
          SliverAppBar(
            expandedHeight: 330,
            pinned: true,

            backgroundColor: Colors.black,

            leading: Padding(
              padding: const EdgeInsets.all(8),

              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.9),

                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),

                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),

                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),

                  child: IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.black),

                    onPressed: () {},
                  ),
                ),
              ),
            ],

            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,

                children: [
                  // IMAGE
                  Image.network(footprint.image, fit: BoxFit.cover),

                  // GRADIENT
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,

                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.75),
                        ],
                      ),
                    ),
                  ),

                  // TITLE
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 25,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          footprint.place,

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 16,
                            ),

                            const SizedBox(width: 6),

                            Text(
                              footprint.date,
                              style: const TextStyle(color: Colors.white),
                            ),

                            const SizedBox(width: 18),

                            const Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 17,
                            ),

                            const SizedBox(width: 6),

                            Text(
                              footprint.time,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // PUBLIC / PRIVATE
                  Align(
                    alignment: Alignment.centerRight,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),

                      decoration: BoxDecoration(
                        color: footprint.isPublic
                            ? Colors.green.shade50
                            : Colors.grey.shade200,

                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Icon(
                            footprint.isPublic
                                ? Icons.public
                                : Icons.lock_outline,

                            size: 16,

                            color: footprint.isPublic
                                ? Colors.green.shade700
                                : Colors.black54,
                          ),

                          const SizedBox(width: 5),

                          Text(
                            footprint.isPublic ? 'Public' : 'Private',

                            style: TextStyle(
                              fontWeight: FontWeight.w600,

                              color: footprint.isPublic
                                  ? Colors.green.shade700
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // MEDIA SUMMARY
                  Row(
                    children: [
                      Expanded(
                        child: _MediaBox(
                          icon: Icons.image_outlined,
                          value: footprint.photoCount,
                          label: 'Photos',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _MediaBox(
                          icon: Icons.videocam_outlined,
                          value: footprint.videoCount,
                          label: 'Videos',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _MediaBox(
                          icon: Icons.mic_none,
                          value: footprint.audioCount,
                          label: 'Audio',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // DESCRIPTION
                  const _SectionTitle(title: 'Description'),

                  const SizedBox(height: 8),

                  Text(
                    footprint.description,

                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // PEOPLE
                  const _SectionTitle(title: 'People With Whom I Visited'),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 90,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,

                      itemCount: footprint.companions.length,

                      itemBuilder: (context, index) {
                        final person = footprint.companions[index];

                        return Padding(
                          padding: const EdgeInsets.only(right: 18),

                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 27,

                                backgroundColor: Colors.grey.shade300,

                                child: Text(
                                  person[0],

                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                person,

                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 25),

                  // HIGHLIGHTS
                  const _SectionTitle(title: 'Highlights'),

                  const SizedBox(height: 15),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,

                    children: footprint.highlights
                        .map((highlight) => _HighlightChip(text: highlight))
                        .toList(),
                  ),

                  const SizedBox(height: 28),

                  // AUDIO
                  if (footprint.audioNote != null) ...[
                    const _SectionTitle(title: 'Audio Note'),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.black87,

                            child: Icon(Icons.play_arrow, color: Colors.white),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                const Text(
                                  'Memory recording',

                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  footprint.audioNote!,

                                  maxLines: 1,

                                  overflow: TextOverflow.ellipsis,

                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Text(
                            '00:45',

                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),
                  ],

                  // NOTES
                  const _SectionTitle(title: 'Notes'),

                  const SizedBox(height: 8),

                  Text(
                    footprint.notes,

                    style: const TextStyle(fontSize: 15, height: 1.6),
                  ),

                  const SizedBox(height: 30),

                  // MAP PLACEHOLDER
                  Container(
                    height: 150,

                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,

                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Icon(Icons.location_on),

                          SizedBox(width: 8),

                          Text(
                            'Location map',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// SECTION TITLE

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,

      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
    );
  }
}

// MEDIA BOX

class _MediaBox extends StatelessWidget {
  final IconData icon;
  final int value;
  final String label;

  const _MediaBox({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        children: [
          Icon(icon),

          const SizedBox(height: 5),

          Text(
            '$value $label',

            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// HIGHLIGHT CHIP

class _HighlightChip extends StatelessWidget {
  final String text;

  const _HighlightChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: Colors.black12),
      ),

      child: Text(
        text,

        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }
}
