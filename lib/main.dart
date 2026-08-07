import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:iwh/screens/home.dart';

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
      home: const Home(),
    );
  }
}
