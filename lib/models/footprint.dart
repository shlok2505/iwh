class Footprint {
  final String id;
  final String place;
  final String date;
  final String time;
  final String image;
  final bool isPublic;
  final int photoCount;
  final int videoCount;
  final int audioCount;
  final String description;
  final List<String> companions;
  final List<String> highlights;
  final String? audioNote;
  final String notes;
  final double latitude;
  final double longitude;
  final String userName;
  final String? userProfileImage;
  final bool isFriend;

  Footprint({
    required this.id,
    required this.place,
    required this.date,
    required this.time,
    required this.image,
    required this.isPublic,
    required this.photoCount,
    required this.videoCount,
    required this.audioCount,
    required this.description,
    required this.companions,
    required this.highlights,
    this.audioNote,
    required this.notes,
    required this.latitude,
    required this.longitude,
    required this.userName,
    this.userProfileImage,
    required this.isFriend,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place,
      'date': date,
      'time': time,
      'image': image,
      'isPublic': isPublic,
      'photoCount': photoCount,
      'videoCount': videoCount,
      'audioCount': audioCount,
      'description': description,
      'companions': companions,
      'highlights': highlights,
      'audioNote': audioNote,
      'notes': notes,
      'latitude': latitude,
      'longitude': longitude,
      'userName': userName,
      'userProfileImage': userProfileImage,
      'isFriend': isFriend,
    };
  }

  factory Footprint.fromMap(Map<String, dynamic> map) {
    return Footprint(
      id: map['id'] ?? '',
      place: map['place'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      image: map['image'] ?? '',
      isPublic: map['isPublic'] ?? true,
      photoCount: map['photoCount'] ?? 0,
      videoCount: map['videoCount'] ?? 0,
      audioCount: map['audioCount'] ?? 0,
      description: map['description'] ?? '',
      companions: List<String>.from(map['companions'] ?? []),
      highlights: List<String>.from(map['highlights'] ?? []),
      audioNote: map['audioNote'],
      notes: map['notes'] ?? '',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
      userName: map['userName'] ?? '',
      userProfileImage: map['userProfileImage'],
      isFriend: map['isFriend'] ?? false,
    );
  }
}
