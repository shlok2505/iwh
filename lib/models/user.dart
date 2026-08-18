class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String bio;
  final String city;
  final String? avatarUrl;
  final int age;
  final String achievement;
  final int footprintCount;
  final int friendsCount;
  final bool isFriend;
  final bool isCurrentUser;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.bio,
    required this.city,
    this.avatarUrl,
    required this.age,
    required this.achievement,
    required this.footprintCount,
    required this.friendsCount,
    this.isFriend = false,
    this.isCurrentUser = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'bio': bio,
      'city': city,
      'avatarUrl': avatarUrl,
      'age': age,
      'achievement': achievement,
      'footprintCount': footprintCount,
      'friendsCount': friendsCount,
      'isFriend': isFriend,
      'isCurrentUser': isCurrentUser,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      city: map['city'] ?? '',
      avatarUrl: map['avatarUrl'],
      age: map['age'] ?? 0,
      achievement: map['achievement'] ?? 'Explorer',
      footprintCount: map['footprintCount'] ?? 0,
      friendsCount: map['friendsCount'] ?? 0,
      isFriend: map['isFriend'] ?? false,
      isCurrentUser: map['isCurrentUser'] ?? false,
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? bio,
    String? city,
    String? avatarUrl,
    int? age,
    String? achievement,
    int? footprintCount,
    int? friendsCount,
    bool? isFriend,
    bool? isCurrentUser,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      city: city ?? this.city,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      age: age ?? this.age,
      achievement: achievement ?? this.achievement,
      footprintCount: footprintCount ?? this.footprintCount,
      friendsCount: friendsCount ?? this.friendsCount,
      isFriend: isFriend ?? this.isFriend,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }
}
