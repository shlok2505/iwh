import 'package:flutter/material.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    final friends = [
      {
        'name': 'Rohan Verma',
        'achievement': 'Explorer',
        'footprints': '78',
        'icon': Icons.location_on,
      },
      {
        'name': 'Ananya Sharma',
        'achievement': 'Photo Lover',
        'footprints': '64',
        'icon': Icons.camera_alt,
      },
      {
        'name': 'Karan Mehta',
        'achievement': 'Legend',
        'footprints': '120',
        'icon': Icons.star,
      },
      {
        'name': 'Ishita Patel',
        'achievement': 'Story Teller',
        'footprints': '45',
        'icon': Icons.chat_bubble,
      },
      {
        'name': 'Navraj Singh',
        'achievement': 'Social Butterfly',
        'footprints': '35',
        'icon': Icons.people,
      },
      {
        'name': 'Meera Iyer',
        'achievement': 'Explorer',
        'footprints': '92',
        'icon': Icons.location_on,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Friends',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt_1),
          ),
        ],
      ),

      body: Column(
        children: [
          // Friends heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

            child: Row(
              children: [
                const Icon(Icons.people, size: 30),

                const SizedBox(width: 10),

                const Text(
                  'My Friends (128)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const Spacer(),

                const Text('Recently Active', style: TextStyle(fontSize: 14)),

                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),

          // Friends list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              itemCount: friends.length,

              itemBuilder: (context, index) {
                final friend = friends[index];

                return _FriendCard(
                  name: friend['name'] as String,
                  achievement: friend['achievement'] as String,
                  footprints: friend['footprints'] as String,
                  icon: friend['icon'] as IconData,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FRIEND CARD
// ============================================================

class _FriendCard extends StatelessWidget {
  final String name;
  final String achievement;
  final String footprints;
  final IconData icon;

  const _FriendCard({
    required this.name,
    required this.achievement,
    required this.footprints,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              const CircleAvatar(
                radius: 38,
                child: Icon(Icons.person, size: 40),
              ),

              // Online indicator
              Positioned(
                right: 0,
                bottom: 2,

                child: Container(
                  width: 15,
                  height: 15,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 15),

          // Name + achievement + footprints
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // Name + achievement
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Achievement tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon, size: 15),

                          const SizedBox(width: 4),

                          Text(
                            achievement,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Footprints
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 20),

                    const SizedBox(width: 5),

                    Text(
                      '$footprints Footprints',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Arrow
          const Icon(Icons.chevron_right, size: 30),
        ],
      ),
    );
  }
}
