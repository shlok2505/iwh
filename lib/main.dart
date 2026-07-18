import 'package:flutter/material.dart';

void main() {
  runApp(const IWasHereApp());
}

class IWasHereApp extends StatelessWidget {
  const IWasHereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I Was Here',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome to I Was Here 👣",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Actions(actions: ScrollIncrementType, child: child),
    );
  }
}
