import 'package:flutter/material.dart';
import 'posting.dart';

export 'posting.dart';

/// Backward-compatible alias for PostingScreen
class PostPresence extends StatelessWidget {
  const PostPresence({super.key});

  @override
  Widget build(BuildContext context) {
    return const PostingScreen();
  }
}
