import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 22,
              child: Icon(Icons.person, size: 30, color: Colors.white),
            ),
            Container(
              width: 300,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  'I Was Here',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
            SizedBox(width: 44),
          ],
        ),
      ),
    );
  }
}
