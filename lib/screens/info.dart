import 'package:flutter/material.dart';
import '../models/place.dart';
import '../data/place.dart';

class AboutThisPlace extends StatelessWidget {
  final Place? place;

  const AboutThisPlace({super.key, this.place});

  @override
  Widget build(BuildContext context) {
    final currentPlace = place ?? defaultPlace;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // HERO SECTION
              // ============================================================
              Stack(
                children: [
                  SizedBox(
                    height: 310,
                    width: double.infinity,
                    child: Image.network(
                      currentPlace.heroImage,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFB9D9E8), Color(0xFF5C8798)],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Dark gradient at bottom
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 150,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0x99000000)],
                        ),
                      ),
                    ),
                  ),

                  // Back button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: _circleButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),

                  // Share button
                  Positioned(
                    top: 16,
                    right: 16,
                    child: _circleButton(
                      icon: Icons.share_outlined,
                      onTap: () {},
                    ),
                  ),

                  // Title
                  Positioned(
                    left: 24,
                    bottom: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentPlace.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 19,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              currentPlace.tagline,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.45),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.category_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 7),
                              Text(
                                currentPlace.category,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ============================================================
              // PLACES TO VISIT
              // ============================================================
              _sectionHeader(
                title: 'Places to Visit Nearby',
                action: 'See all',
                onTap: () {},
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 265,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: nearbyPlaces.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return _placeCard(context, nearbyPlaces[index]);
                  },
                ),
              ),

              const SizedBox(height: 24),

              // ============================================================
              // ABOUT + HISTORY
              // ============================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(0.05),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _infoSection(
                        icon: Icons.info_outline_rounded,
                        iconColor: const Color(0xFF5797E8),
                        title: 'About ${currentPlace.name}',
                        description: currentPlace.about,
                        onTap: () {},
                      ),

                      Divider(
                        height: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey.shade200,
                      ),

                      _infoSection(
                        icon: Icons.history_rounded,
                        iconColor: const Color(0xFF8064D9),
                        title: 'History',
                        description: currentPlace.history,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ============================================================
              // WEATHER
              // ============================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _weatherCard(currentPlace),
              ),

              const SizedBox(height: 28),

              // ============================================================
              // HOSTELS
              // ============================================================
              _sectionHeader(
                title: 'Hostels & Stays Nearby',
                action: 'See all',
                onTap: () {},
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 260,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: hostels.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return _hostelCard(hostels[index]);
                  },
                ),
              ),

              const SizedBox(height: 28),

              // ============================================================
              // RESTAURANTS
              // ============================================================
              _sectionHeader(
                title: 'Restaurants Nearby',
                action: 'See all',
                onTap: () {},
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 260,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurants.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return _restaurantCard(restaurants[index]);
                  },
                ),
              ),

              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // SECTION HEADER
  // ========================================================================

  Widget _sectionHeader({
    required String title,
    required String action,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              action,
              style: const TextStyle(
                color: Color(0xFF1689E8),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // PLACE CARD
  // ========================================================================

  Widget _placeCard(BuildContext context, Map<String, dynamic> place) {
    final placeName = place['name'] as String;
    final targetPlace = mockPlaces.firstWhere(
      (p) => p.name.toLowerCase().contains(placeName.toLowerCase()),
      orElse: () => Place(
        id: 'place_${placeName.toLowerCase().replaceAll(' ', '_')}',
        name: placeName,
        tagline: place['type'] ?? 'Iconic Destination',
        category: place['type'] ?? 'Landmark',
        city: 'Mumbai, Maharashtra',
        latitude: 18.9431,
        longitude: 72.8236,
        heroImage: place['image'] ?? defaultPlace.heroImage,
        about:
            'One of the most remarkable destinations in Mumbai, cherished by locals and tourists alike.',
        history:
            'A historic spot deeply tied to the cultural fabric and architectural heritage of Mumbai.',
        rating: double.tryParse(place['rating']?.toString() ?? '4.5') ?? 4.5,
        reviewCount: 850,
        weatherTemp: '28°C',
        weatherCondition: 'Sunny / Coastal',
        bestTime: 'Morning or Sunset',
        totalFootprints: 110,
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AboutThisPlace(place: targetPlace),
          ),
        );
      },
      child: Container(
        width: 210,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 3),
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 135,
                  width: double.infinity,
                  child: Image.network(
                    place['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.image_outlined,
                          size: 45,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),

                Positioned(
                  right: 9,
                  top: 9,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      place['distance'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${place['rating']} (${place['reviews']})',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      Icon(place['icon'], color: Colors.grey.shade600, size: 17),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          place['type'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================================================
  // ABOUT / HISTORY SECTION
  // ========================================================================

  Widget _infoSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 23),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Row(
                        children: [
                          Text(
                            'Read more',
                            style: TextStyle(
                              color: Color(0xFF1689E8),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xFF1689E8),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 7),

                Text(
                  description,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.45,
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // WEATHER
  // ========================================================================

  Widget _weatherCard(Place currentPlace) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEFF7FF), Color(0xFFF6F3FF)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                "Today's Weather",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 6),
              Icon(Icons.cloud_outlined, size: 19, color: Color(0xFF1689E8)),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentPlace.weatherTemp,
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      currentPlace.weatherCondition,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),

              Container(height: 75, width: 1, color: Colors.grey.shade300),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  children: [
                    _weatherDetail(
                      Icons.water_drop_outlined,
                      'Humidity',
                      '78%',
                    ),
                    const SizedBox(height: 12),
                    _weatherDetail(Icons.air_rounded, 'Wind', '12 km/h'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            '3-Day Forecast',
            style: TextStyle(
              color: Color(0xFF1689E8),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _forecastDay('Sat', '🌤️', '29° / 24°'),
              _forecastDay('Sun', '🌧️', '28° / 24°'),
              _forecastDay('Mon', '☀️', '30° / 24°'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _weatherDetail(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF1689E8), size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
            ),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  Widget _forecastDay(String day, String icon, String temperature) {
    return Expanded(
      child: Column(
        children: [
          Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          const SizedBox(height: 7),
          Text(icon, style: const TextStyle(fontSize: 23)),
          const SizedBox(height: 5),
          Text(
            temperature,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // HOSTEL CARD
  // ========================================================================

  Widget _hostelCard(Map<String, dynamic> hostel) {
    return Container(
      width: 205,
      decoration: _cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 130,
                width: double.infinity,
                child: Image.network(
                  hostel['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.hotel_outlined,
                        size: 42,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),

              Positioned(right: 10, top: 9, child: _favoriteButton()),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hostel['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 17,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${hostel['rating']} (${hostel['reviews']})',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 11,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey.shade600,
                      size: 15,
                    ),
                    Text(
                      hostel['distance'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  hostel['price'],
                  style: const TextStyle(
                    color: Color(0xFF1689E8),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // RESTAURANT CARD
  // ========================================================================

  Widget _restaurantCard(Map<String, dynamic> restaurant) {
    return Container(
      width: 205,
      decoration: _cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 130,
                width: double.infinity,
                child: Image.network(
                  restaurant['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.restaurant_outlined,
                        size: 42,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),

              Positioned(right: 10, top: 9, child: _favoriteButton()),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(11),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 17,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${restaurant['rating']} (${restaurant['reviews']})',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 11,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey.shade600,
                      size: 15,
                    ),
                    Text(
                      restaurant['distance'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Container(
                      height: 7,
                      width: 7,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        restaurant['type'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // COMMON WIDGETS
  // ========================================================================

  Widget _favoriteButton() {
    return Container(
      height: 34,
      width: 34,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.favorite_border_rounded, size: 20),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.12)),
          ],
        ),
        child: Icon(icon),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          offset: const Offset(0, 3),
          color: Colors.black.withOpacity(0.07),
        ),
      ],
    );
  }
}

// ============================================================================
// DUMMY DATA
// ============================================================================

final List<Map<String, dynamic>> nearbyPlaces = [
  {
    'name': 'Gateway of India',
    'distance': '4.2 km',
    'rating': '4.7',
    'reviews': '2.3k',
    'type': 'Historical Landmark',
    'icon': Icons.account_balance_outlined,
    'image':
        'https://images.unsplash.com/photo-1570168007204-dfb528c6958f'
        '?auto=format&fit=crop&w=600&q=80',
  },
  {
    'name': 'Marine Drive',
    'distance': '1.8 km',
    'rating': '4.8',
    'reviews': '1.8k',
    'type': 'Scenic Spot',
    'icon': Icons.park_outlined,
    'image':
        'https://images.unsplash.com/photo-1570168007204-dfb528c6958f'
        '?auto=format&fit=crop&w=600&q=80',
  },
  {
    'name': 'Elephanta Caves',
    'distance': '10.6 km',
    'rating': '4.6',
    'reviews': '982',
    'type': 'Historical Site',
    'icon': Icons.account_balance_outlined,
    'image':
        'https://images.unsplash.com/photo-1600100397608-f010ba90d51b'
        '?auto=format&fit=crop&w=600&q=80',
  },
  {
    'name': 'Siddhivinayak Temple',
    'distance': '5.8 km',
    'rating': '4.9',
    'reviews': '1.2k',
    'type': 'Religious Place',
    'icon': Icons.temple_hindu_outlined,
    'image':
        'https://images.unsplash.com/photo-1606298855672-3efb63017be8'
        '?auto=format&fit=crop&w=600&q=80',
  },
];

final List<Map<String, dynamic>> hostels = [
  {
    'name': 'Zostel Mumbai',
    'rating': '4.3',
    'reviews': '1.1k',
    'distance': '1.2 km',
    'price': '₹850 / night',
    'image':
        'https://images.unsplash.com/photo-1520277739336-7bf67edfa768'
        '?auto=format&fit=crop&w=600&q=80',
  },
  {
    'name': 'Backpacker Panda',
    'rating': '4.2',
    'reviews': '892',
    'distance': '2.1 km',
    'price': '₹750 / night',
    'image':
        'https://images.unsplash.com/photo-1555854877-bab0e564b8d5'
        '?auto=format&fit=crop&w=600&q=80',
  },
  {
    'name': 'The Hosteller Mumbai',
    'rating': '4.4',
    'reviews': '1.3k',
    'distance': '2.8 km',
    'price': '₹799 / night',
    'image':
        'https://images.unsplash.com/photo-1560185893-a55cbc8c57e8'
        '?auto=format&fit=crop&w=600&q=80',
  },
  {
    'name': 'Locomo Hostel',
    'rating': '4.1',
    'reviews': '745',
    'distance': '3.1 km',
    'price': '₹699 / night',
    'image':
        'https://images.unsplash.com/photo-1540518614846-7eded433c457'
        '?auto=format&fit=crop&w=600&q=80',
  },
];

final List<Map<String, dynamic>> restaurants = [
  {
    'name': 'Pizza By The Bay',
    'rating': '4.5',
    'reviews': '2.4k',
    'distance': '800 m',
    'type': 'Italian • Cafe',
    'image':
        'https://images.unsplash.com/photo-1574071318508-1cdbab80d002'
        '?auto=format&fit=crop&w=600&q=80',
  },
  {
    'name': 'Trishna Restaurant',
    'rating': '4.6',
    'reviews': '1.9k',
    'distance': '1.1 km',
    'type': 'Seafood • Indian',
    'image':
        'https://images.unsplash.com/photo-1547592180-85f173990554'
        '?auto=format&fit=crop&w=600&q=80',
  },
  {
    'name': 'Bastian',
    'rating': '4.4',
    'reviews': '2.0k',
    'distance': '1.3 km',
    'type': 'Cafe • Continental',
    'image':
        'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f'
        '?auto=format&fit=crop&w=600&q=80',
  },
  {
    'name': 'Swati Snacks',
    'rating': '4.3',
    'reviews': '1.6k',
    'distance': '1.8 km',
    'type': 'Veg • Street Food',
    'image':
        'https://images.unsplash.com/photo-1601050690597-df0568f70950'
        '?auto=format&fit=crop&w=600&q=80',
  },
];
