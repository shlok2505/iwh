import 'package:flutter/material.dart';
import '../models/user.dart';
import '../data/user.dart';
import '../data/footprint.dart';
import '../widgets/footprint_card.dart';
import 'pastFp.dart';

class Profile extends StatelessWidget {
  final User? user;

  const Profile({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final profileUser = user ?? currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          profileUser.isCurrentUser ? 'My Profile' : profileUser.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: profileUser.avatarUrl != null
                        ? NetworkImage(profileUser.avatarUrl!)
                        : null,
                    child: profileUser.avatarUrl == null
                        ? Text(
                            profileUser.name.isNotEmpty
                                ? profileUser.name.substring(0, 1).toUpperCase()
                                : 'U',
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          )
                        : null,
                  ),

                  const SizedBox(width: 15),

                  // Name and information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileUser.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          '@${profileUser.username.replaceAll('@', '')}',
                          style: const TextStyle(fontSize: 15),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          profileUser.bio,
                          style: const TextStyle(fontSize: 14),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 18),
                            const SizedBox(width: 4),
                            Text(profileUser.city),
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

                      Text(
                        '${profileUser.friendsCount}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Text('Friends'),

                      const SizedBox(height: 20),

                      const Icon(Icons.location_on, size: 30),

                      const SizedBox(height: 5),

                      Text(
                        '${profileUser.footprintCount}',
                        style: const TextStyle(
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
              _sectionHeader(
                Icons.location_on,
                profileUser.isCurrentUser
                    ? 'My Footprints'
                    : "${profileUser.name.split(' ').first}'s Footprints",
              ),

              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: footprints.length.clamp(0, 4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  return FootprintCard(
                    footprint: footprints[index],
                    isCompact: true,
                  );
                },
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PastFp(),
                    ),
                  );
                },
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


