import 'package:flutter/material.dart';
import 'package:iwh/screens/pastFp.dart';
import 'package:iwh/screens/aroundMe.dart';
import 'package:iwh/screens/info.dart';

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(
          top: 24,
          left: 15,
          right: 15,
          bottom: 25,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F0E6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(38),
            topRight: Radius.circular(38),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // PAST FOOTPRINTS
              _bottomButton(
                icon: Icons.directions_walk,
                title: 'Past Footprints',
                iconColor: const Color(0xFF607D6B),
                backgroundColor: const Color(0xFFE5EBDD),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PastFp()),
                  );
                },
              ),

              // ABOUT THIS PLACE
              _bottomButton(
                icon: Icons.info_outline,
                title: 'About This Place',
                iconColor: const Color(0xFF526B7A),
                backgroundColor: const Color(0xFFE4EDF2),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutThisPlace(),
                    ),
                  );
                },
              ),

              // RECENT BEEN HERE
              _bottomButton(
                icon: Icons.people_outline,
                title: 'Around Me',
                iconColor: const Color(0xFF68638B),
                backgroundColor: const Color(0xFFECE8F2),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AroundMe()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomButton({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 105,
        child: Column(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
              ),
              child: Icon(icon, size: 34, color: iconColor),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF526B7A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
