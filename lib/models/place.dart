class Place {
  final String id;
  final String name;
  final String tagline;
  final String category;
  final String city;
  final String? address;
  final double latitude;
  final double longitude;
  final String heroImage;
  final List<String> galleryImages;
  final String about;
  final String history;
  final double rating;
  final int reviewCount;
  final String weatherTemp;
  final String weatherCondition;
  final String bestTime;
  final int totalFootprints;

  Place({
    required this.id,
    required this.name,
    required this.tagline,
    required this.category,
    required this.city,
    this.address,
    required this.latitude,
    required this.longitude,
    required this.heroImage,
    this.galleryImages = const [],
    required this.about,
    required this.history,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.weatherTemp = '28°C',
    this.weatherCondition = 'Sunny / Humid',
    this.bestTime = 'Oct - Mar',
    this.totalFootprints = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'category': category,
      'city': city,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'heroImage': heroImage,
      'galleryImages': galleryImages,
      'about': about,
      'history': history,
      'rating': rating,
      'reviewCount': reviewCount,
      'weatherTemp': weatherTemp,
      'weatherCondition': weatherCondition,
      'bestTime': bestTime,
      'totalFootprints': totalFootprints,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      tagline: map['tagline'] ?? '',
      category: map['category'] ?? 'General',
      city: map['city'] ?? '',
      address: map['address'],
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
      heroImage: map['heroImage'] ?? '',
      galleryImages: List<String>.from(map['galleryImages'] ?? []),
      about: map['about'] ?? '',
      history: map['history'] ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 4.5,
      reviewCount: map['reviewCount'] ?? 0,
      weatherTemp: map['weatherTemp'] ?? '28°C',
      weatherCondition: map['weatherCondition'] ?? 'Sunny / Humid',
      bestTime: map['bestTime'] ?? 'Oct - Mar',
      totalFootprints: map['totalFootprints'] ?? 0,
    );
  }

  Place copyWith({
    String? id,
    String? name,
    String? tagline,
    String? category,
    String? city,
    String? address,
    double? latitude,
    double? longitude,
    String? heroImage,
    List<String>? galleryImages,
    String? about,
    String? history,
    double? rating,
    int? reviewCount,
    String? weatherTemp,
    String? weatherCondition,
    String? bestTime,
    int? totalFootprints,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      category: category ?? this.category,
      city: city ?? this.city,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      heroImage: heroImage ?? this.heroImage,
      galleryImages: galleryImages ?? this.galleryImages,
      about: about ?? this.about,
      history: history ?? this.history,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      weatherTemp: weatherTemp ?? this.weatherTemp,
      weatherCondition: weatherCondition ?? this.weatherCondition,
      bestTime: bestTime ?? this.bestTime,
      totalFootprints: totalFootprints ?? this.totalFootprints,
    );
  }
}
