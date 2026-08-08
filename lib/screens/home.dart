import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(28.6139, 77.209),
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
            ],
          ),
          HomeHeader(
            onProfileTap: () {
              setState(() {
                isDrawerOpen = !isDrawerOpen;
              });
            },
          ),
          const HomeFp(),
          const HomeBottom(),
          if (isDrawerOpen)
            GestureDetector(
              onTap: () {
                setState(() {
                  isDrawerOpen = false;
                });
              },
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          if (isDrawerOpen) const CustomDrawer(),
        ],
      ),
    );
  }
}
