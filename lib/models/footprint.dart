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
  });
}
