import 'package:flutter/material.dart';

import 'package:iwh/screens/profile.dart';
import 'package:iwh/screens/friendList.dart';
import 'package:iwh/screens/userInfo.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.82,

      child: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),

              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),

              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 110,
                    height: 110,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple.shade100,
                    ),

                    child: const Icon(
                      Icons.directions_walk,
                      size: 60,
                      color: Colors.deepPurple,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Footprints',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Explore • Connect • Remember',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),

            // ================= MENU =================
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),

                children: [
                  _drawerButton(
                    context,
                    icon: Icons.person_outline,
                    title: 'Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile(),
                        ),
                      );
                    },
                  ),

                  _drawerButton(
                    context,
                    icon: Icons.people_outline,
                    title: 'Friends',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FriendList(),
                        ),
                      );
                    },
                  ),

                  _drawerButton(
                    context,
                    icon: Icons.account_box_outlined,
                    title: 'User Info',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserInfo(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  const Divider(),

                  const SizedBox(height: 10),

                  // ================= SOCIAL =================
                  _socialButton(
                    icon: Icons.camera_alt_outlined,
                    title: 'Follow us on Instagram',
                    username: '@footprints.app',
                    onTap: () {
                      // Instagram link later
                    },
                  ),

                  _socialButton(
                    icon: Icons.close,
                    title: 'Follow us on X',
                    username: '@footprints_app',
                    onTap: () {
                      // X link later
                    },
                  ),
                ],
              ),
            ),

            // ================= FOOTER =================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),

              color: Colors.deepPurple.shade50,

              child: const Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.deepPurple,
                    size: 28,
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    child: Text(
                      'Made with love for explorers like you.',
                      style: TextStyle(fontSize: 14, color: Colors.deepPurple),
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

  // ============================================================
  // DRAWER BUTTON
  // ============================================================

  static Widget _drawerButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: Colors.grey.shade300),
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),

        leading: Container(
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(14),
          ),

          child: Icon(icon, color: Colors.deepPurple, size: 27),
        ),

        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),

        trailing: const Icon(Icons.chevron_right, size: 30),

        onTap: onTap,
      ),
    );
  }

  // ============================================================
  // SOCIAL BUTTON
  // ============================================================

  static Widget _socialButton({
    required IconData icon,
    required String title,
    required String username,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),

      leading: Container(
        width: 50,
        height: 50,

        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(14),
        ),

        child: Icon(icon, color: Colors.deepPurple, size: 28),
      ),

      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),

      subtitle: Text(
        username,
        style: const TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.w500,
        ),
      ),

      trailing: const Icon(Icons.chevron_right),

      onTap: onTap,
    );
  }
}
