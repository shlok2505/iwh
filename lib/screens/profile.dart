import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              // ---------------- PROFILE SECTION ----------------
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Avatar
                  const CircleAvatar(
                    radius: 55,
                    child: Icon(Icons.person, size: 60),
                  ),

                  const SizedBox(width: 15),

                  // Name and information
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shlok Singh',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text('@shlok_here', style: TextStyle(fontSize: 15)),

                        SizedBox(height: 8),

                        Text(
                          'Traveller • Explorer • Dreamer',
                          style: TextStyle(fontSize: 14),
                        ),

                        SizedBox(height: 8),

                        Row(
                          children: [
                            Icon(Icons.location_on, size: 18),
                            SizedBox(width: 4),
                            Text('Mumbai, India'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Stats
                  Column(
                    children: [
                      const Icon(Icons.people, size: 30),

                      const SizedBox(height: 5),

                      const Text(
                        '128',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text('Friends'),

                      const SizedBox(height: 20),

                      const Icon(Icons.location_on, size: 30),

                      const SizedBox(height: 5),

                      const Text(
                        '56',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text('Footprints'),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ---------------- ACHIEVEMENTS ----------------
              _sectionHeader(Icons.emoji_events, 'Achievements'),

              const SizedBox(height: 15),

              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,

                children: const [
                  _Achievement(
                    icon: Icons.location_on,
                    title: 'First Footprint',
                    subtitle: 'Leave your first footprint',
                  ),

                  _Achievement(
                    icon: Icons.hiking,
                    title: 'Explorer',
                    subtitle: 'Visit 10 different places',
                  ),

                  _Achievement(
                    icon: Icons.camera_alt,
                    title: 'Photo Lover',
                    subtitle: 'Share 25 photos',
                  ),

                  _Achievement(
                    icon: Icons.people,
                    title: 'Social Butterfly',
                    subtitle: 'Add 25 friends',
                  ),

                  _Achievement(
                    icon: Icons.chat_bubble,
                    title: 'Story Teller',
                    subtitle: 'Share 10 stories',
                  ),

                  _Achievement(
                    icon: Icons.star,
                    title: 'Legend',
                    subtitle: 'Reach 50 footprints',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ---------------- FOOTPRINTS ----------------
              _sectionHeader(Icons.location_on, 'My Footprints'),

              const SizedBox(height: 10),

              const _Footprint(
                icon: Icons.beach_access,
                title: 'Juhu Beach',
                location: 'Mumbai, India',
                time: 'Yesterday • Photo',
              ),

              const _Footprint(
                icon: Icons.terrain,
                title: 'Lonavala Hills',
                location: 'Lonavala, Maharashtra',
                time: '3 days ago • Photo',
              ),

              const _Footprint(
                icon: Icons.account_balance,
                title: 'Gateway of India',
                location: 'Mumbai, India',
                time: '1 week ago • Story',
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {},
                child: const Text(
                  'View all footprints →',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Section header
  static Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 28),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// ============================================================
// ACHIEVEMENT WIDGET
// ============================================================

class _Achievement extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _Achievement({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 42),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),

          const SizedBox(height: 5),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FOOTPRINT WIDGET
// ============================================================

class _Footprint extends StatelessWidget {
  final IconData icon;
  final String title;
  final String location;
  final String time;

  const _Footprint({
    required this.icon,
    required this.title,
    required this.location,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),

        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Row(
        children: [
          // Placeholder for footprint image
          Container(
            width: 80,
            height: 70,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),

            child: Icon(icon, size: 35),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(location),

                const SizedBox(height: 5),

                Text(time, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),

          const Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
