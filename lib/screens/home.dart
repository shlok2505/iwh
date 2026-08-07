import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:iwh/widgets/homeHeader.dart';
import 'package:iwh/widgets/homeFp.dart';
import 'package:iwh/widgets/homebottom.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(51.5, -0.09),
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.iwh',
              ),
            ],
          ),
          const HomeHeader(),
          const HomeFp(),
          const HomeBottom(),
        ],
      ),
    );
  }
}
