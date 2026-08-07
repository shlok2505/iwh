import 'package:flutter/material.dart';

class HomeBottom extends StatelessWidget {
  const HomeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(
              Icons.location_history_rounded,
              color: Colors.blueGrey,
              size: 30,
            ),
            onPressed: () {
              // Handle home button press
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Colors.blueGrey,
              size: 30,
            ),
            onPressed: () {
              // Handle search button press
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.recent_actors_rounded,
              color: Colors.blueGrey,
              size: 30,
            ),
            onPressed: () {
              // Handle profile button press
            },
          ),
        ],
      ),
    );
  }
}
