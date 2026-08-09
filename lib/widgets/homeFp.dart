import 'package:flutter/material.dart';

class HomeFp extends StatelessWidget {
  const HomeFp({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CURRENT LOCATION
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(0.12),
            ),
            child: Center(
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  border: Border.all(color: Colors.white, width: 6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // MARK YOUR PRESENCE
        Positioned(
          left: 24,
          right: 24,
          bottom: 210,
          child: GestureDetector(
            onTap: () {
              // TODO: Mark presence
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F0E6),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // LOCATION ICON
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE4EBDD),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_on,
                      size: 32,
                      color: Color(0xFF526B7A),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // TEXT
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mark your presence',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF526B7A),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Let others know you’ve been here',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF687B86),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ARROW
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF526B7A),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
