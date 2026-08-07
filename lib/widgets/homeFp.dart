import 'package:flutter/material.dart';

class HomeFp extends StatelessWidget {
  const HomeFp({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                'Leave a FootPrint...',
                style: TextStyle(color: Colors.blueGrey, fontSize: 20),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add_location_alt,
              color: Color.fromARGB(255, 137, 30, 30),
              size: 50,
            ),
            onPressed: () {
              // Handle button press
            },
          ),
        ],
      ),
    );
  }
}
