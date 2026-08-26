import 'package:flutter/material.dart';
import 'package:iwh/screens/posting.dart';
import 'package:iwh/widgets/homeHeader.dart';
import 'package:iwh/widgets/homeFp.dart';
import 'package:iwh/widgets/homebottom.dart';
import 'package:iwh/widgets/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDrawerOpen = false;
  Key feedKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      body: Stack(
        children: [
          Column(
            children: [
              HomeHeader(
                onProfileTap: () {
                  setState(() {
                    isDrawerOpen = !isDrawerOpen;
                  });
                },
              ),
              Expanded(child: HomeFeed(key: feedKey)),
            ],
          ),
          const HomeBottom(),
          // Floating + Button (Share Your Moment / Posting)
          Positioned(
            right: 18,
            bottom: 125,
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostingScreen(),
                  ),
                );
                setState(() {
                  feedKey = UniqueKey();
                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF3D5A40),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
          if (isDrawerOpen)
            GestureDetector(
              onTap: () {
                setState(() {
                  isDrawerOpen = false;
                });
              },
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
            ),
          if (isDrawerOpen) const CustomDrawer(),
        ],
      ),
    );
  }
}
