import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../data/footprint.dart';
import '../models/presence.dart';
import 'presenceSc.dart';
import 'dart:ui' as ui;

class AroundMe extends StatefulWidget {
  const AroundMe({super.key});

  @override
  State<AroundMe> createState() => _AroundMeState();
}

class _AroundMeState extends State<AroundMe> {
  final MapController _mapController = MapController();

  // Temporary current location.
  // Later this will come from the user's GPS location.
  final LatLng currentLocation = const LatLng(19.0760, 72.8777);

  @override
  Widget build(BuildContext context) {
    // Only public footprints can appear in Around Me.
    final nearbyFootprints = footprints
        .where((footprint) => footprint.isPublic && !footprint.isMemory)
        .toList();

    final friendCount = nearbyFootprints
        .where((footprint) => footprint.isFriend)
        .length;

    final publicCount = nearbyFootprints
        .where((footprint) => !footprint.isFriend)
        .length;

    return Scaffold(
      body: Stack(
        children: [
          // ==========================================================
          // MAP
          // ==========================================================
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: currentLocation,
                initialZoom: 12.8,
                minZoom: 10,
                maxZoom: 18,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.footprints',
                ),

                MarkerLayer(
                  markers: [
                    // ------------------------------------------------
                    // CURRENT USER LOCATION
                    // ------------------------------------------------
                    Marker(
                      point: currentLocation,
                      width: 70,
                      height: 70,
                      child: _buildCurrentLocationMarker(),
                    ),

                    // ------------------------------------------------
                    // FOOTPRINT MARKERS
                    // ------------------------------------------------
                    ...nearbyFootprints.map((footprint) {
                      return Marker(
                        point: LatLng(footprint.latitude, footprint.longitude),
                        width: 75,
                        height: 85,
                        child: GestureDetector(
                          onTap: () {
                            _showFootprintPreview(footprint);
                          },
                          child: footprint.isFriend
                              ? _buildFriendMarker(footprint)
                              : _buildPublicMarker(footprint),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),

          // ==========================================================
          // TOP HEADER
          // ==========================================================
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.96),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // BACK BUTTON
                    _roundButton(
                      icon: Icons.arrow_back_ios_new,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    const SizedBox(width: 18),

                    // TITLE
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Around Me',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Footprints around you',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    // FILTER BUTTON
                    _roundButton(
                      icon: Icons.tune,
                      onTap: () {
                        _showFilterSheet();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ==========================================================
          // MAP CONTROLS
          // ==========================================================
          Positioned(
            right: 20,
            bottom: 300,
            child: Column(
              children: [
                _mapControl(
                  icon: Icons.my_location,
                  onTap: () {
                    _mapController.move(currentLocation, 13);
                  },
                ),

                const SizedBox(height: 12),

                _mapControl(
                  icon: Icons.navigation,
                  onTap: () {
                    _mapController.move(currentLocation, 15);
                  },
                ),
              ],
            ),
          ),

          // ==========================================================
          // FOOTPRINT COUNT
          // ==========================================================
          Positioned(
            left: 24,
            right: 24,
            bottom: 245,
            child: _buildFootprintCount(
              total: nearbyFootprints.length,
              friends: friendCount,
              public: publicCount,
            ),
          ),

          // ==========================================================
          // RECENT NEARBY SLIDER
          // ==========================================================
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildRecentSlider(nearbyFootprints),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // CURRENT LOCATION MARKER
  // ================================================================

  Widget _buildCurrentLocationMarker() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.withOpacity(0.12),
      ),
      child: Center(
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(color: Colors.blue.withOpacity(0.35), blurRadius: 12),
            ],
          ),
        ),
      ),
    );
  }

  // ================================================================
  // FRIEND MARKER
  // ================================================================

  Widget _buildFriendMarker(Footprint footprint) {
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.blue, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: footprint.userProfileImage != null
                ? Image.network(
                    footprint.userProfileImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.person, color: Colors.grey),
                  )
                : const Icon(Icons.person, color: Colors.grey),
          ),
        ),

        // POINTER
        CustomPaint(
          size: const Size(14, 8),
          painter: _TrianglePainter(color: Colors.blue),
        ),
      ],
    );
  }

  // ================================================================
  // PUBLIC MARKER
  // ================================================================

  Widget _buildPublicMarker(Footprint footprint) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 58,
              height: 58,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.network(
                  footprint.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.place, color: Colors.grey),
                  ),
                ),
              ),
            ),

            // PLUS ICON
            Positioned(
              right: -5,
              bottom: -5,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),

        // POINTER
        CustomPaint(
          size: const Size(14, 8),
          painter: _TrianglePainter(color: Colors.white),
        ),
      ],
    );
  }

  // ================================================================
  // FOOTPRINT COUNT CARD
  // ================================================================

  Widget _buildFootprintCount({
    required int total,
    required int friends,
    required int public,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.location_on, color: Colors.blue),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$total footprints nearby',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$friends from friends  •  $public public',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),

          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.keyboard_arrow_up),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // RECENT NEARBY SLIDER
  // ================================================================

  Widget _buildRecentSlider(List<Footprint> nearbyFootprints) {
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 22),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HANDLE
            Center(
              child: Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const Text(
                    'Recent Nearby',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),

                  const Spacer(),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            // HORIZONTAL SLIDER
            SizedBox(
              height: 265,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 24, right: 24),
                physics: const BouncingScrollPhysics(),
                itemCount: nearbyFootprints.length,
                itemBuilder: (context, index) {
                  return _buildFootprintCard(nearbyFootprints[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // FOOTPRINT CARD
  // ================================================================

  Widget _buildFootprintCard(Footprint footprint) {
    final bool isFriend = footprint.isFriend;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FootprintDetail(footprint: footprint),
          ),
        );
      },
      child: Container(
        width: 190,
        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: Image.network(
                    footprint.image,
                    height: 135,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 135,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),

                // FRIEND / PUBLIC LABEL
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: isFriend ? Colors.blue : Colors.black54,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      isFriend ? 'FRIEND' : 'PUBLIC',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // USER
                  Text(
                    footprint.userName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // PLACE
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 15,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 3),

                      Expanded(
                        child: Text(
                          footprint.place,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // DATE + TIME
                  Text(
                    '${footprint.date} • ${footprint.time}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // FOOTPRINT PREVIEW
  // ================================================================

  void _showFootprintPreview(Footprint footprint) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                footprint.userName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(footprint.place, style: const TextStyle(color: Colors.grey)),

              const SizedBox(height: 10),

              Text(
                '${footprint.date} • ${footprint.time}',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),

              const SizedBox(height: 14),

              Text(footprint.description, style: const TextStyle(fontSize: 15)),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FootprintDetail(footprint: footprint),
                      ),
                    );
                  },
                  child: const Text('View Footprint'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================================================================
  // FILTER SHEET
  // ================================================================

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Show Footprints',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                ListTile(
                  leading: const Icon(Icons.people, color: Colors.blue),
                  title: const Text('Friends'),
                  trailing: Switch(value: true, onChanged: (_) {}),
                ),

                ListTile(
                  leading: const Icon(Icons.public, color: Colors.grey),
                  title: const Text('Public'),
                  trailing: Switch(value: true, onChanged: (_) {}),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================================================================
  // ROUND BUTTON
  // ================================================================

  Widget _roundButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
          ],
        ),
        child: Icon(icon, color: Colors.black87),
      ),
    );
  }

  // ================================================================
  // MAP CONTROL
  // ================================================================

  Widget _mapControl({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 10),
          ],
        ),
        child: Icon(icon, color: Colors.blue, size: 25),
      ),
    );
  }
}

// ================================================================
// TRIANGLE PAINTER
// ================================================================

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = ui.Path();

    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
