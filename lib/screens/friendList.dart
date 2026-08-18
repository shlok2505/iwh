import 'package:flutter/material.dart';

import '../data/user.dart';
import '../models/user.dart';
import '../widgets/user_card.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5EF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Friends',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black87),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt_1, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          // FRIENDS HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.people, size: 28, color: Color(0xFF3182CE)),
                const SizedBox(width: 10),
                Text(
                  'My Friends (${mockUsers.length})',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Recently Active',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black54,
                  size: 20,
                ),
              ],
            ),
          ),

          // FRIENDS GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: mockUsers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (context, index) {
                final User friend = mockUsers[index];
                return UserCard(
                  user: friend,
                  isGrid: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
