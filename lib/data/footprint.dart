import '../models/footprint.dart';

final List<Footprint> footprints = [
  Footprint(
    id: 'fp001',
    place: 'Marine Drive, Mumbai',
    date: '10 Aug 2026',
    time: '6:45 PM',
    image: 'assets/images/marine_drive.jpg',
    isPublic: true,

    photoCount: 4,
    videoCount: 1,
    audioCount: 0,

    description:
        'A peaceful evening at Marine Drive with a beautiful sunset and cool sea breeze.',

    companions: ['Rahul', 'Aditya'],

    highlights: ['Sunset', 'Sea view', 'Evening walk'],

    audioNote: null,

    notes: 'One of the best places to relax after a long day.',

    latitude: 18.9431,
    longitude: 72.8236,

    userName: 'Rahul',
    userProfileImage: 'assets/images/rahul.jpg',

    isFriend: true,
  ),

  Footprint(
    id: 'fp002',
    place: 'Juhu Beach, Mumbai',
    date: '10 Aug 2026',
    time: '5:20 PM',
    image: 'assets/images/juhu_beach.jpg',
    isPublic: true,

    photoCount: 5,
    videoCount: 2,
    audioCount: 1,

    description:
        'Spent a relaxing evening watching the waves and walking along the beach.',

    companions: ['Priya'],

    highlights: ['Beach', 'Sunset', 'Street food'],

    audioNote: 'The waves were incredibly peaceful today.',

    notes: 'Would definitely come back here during sunset.',

    latitude: 19.0988,
    longitude: 72.8268,

    userName: 'Priya',
    userProfileImage: 'assets/images/priya.jpg',

    isFriend: true,
  ),

  Footprint(
    id: 'fp003',
    place: 'Gateway of India, Mumbai',
    date: '10 Aug 2026',
    time: '3:15 PM',
    image: 'assets/images/gateway.jpg',
    isPublic: true,

    photoCount: 3,
    videoCount: 0,
    audioCount: 0,

    description:
        'Visited one of Mumbai’s most iconic landmarks and spent some time near the waterfront.',

    companions: [],

    highlights: ['Architecture', 'Waterfront', 'Photography'],

    audioNote: null,

    notes: 'The architecture looks incredible in the afternoon light.',

    latitude: 18.9220,
    longitude: 72.8347,

    userName: 'Anonymous',
    userProfileImage: null,

    isFriend: false,
  ),

  Footprint(
    id: 'fp004',
    place: 'Bandra Fort, Mumbai',
    date: '10 Aug 2026',
    time: '8:10 AM',
    image: 'assets/images/bandra_fort.jpg',
    isPublic: true,

    photoCount: 2,
    videoCount: 1,
    audioCount: 0,

    description:
        'A quiet morning walk around Bandra Fort with a beautiful view of the sea.',

    companions: [],

    highlights: ['Morning', 'Sea view', 'Photography'],

    audioNote: null,

    notes: 'Very peaceful in the morning before it gets crowded.',

    latitude: 19.0437,
    longitude: 72.8194,

    userName: 'Wanderer',
    userProfileImage: null,

    isFriend: false,
  ),

  Footprint(
    id: 'fp005',
    place: 'Sanjay Gandhi National Park',
    date: '8 Aug 2026',
    time: '11:30 AM',
    image: 'assets/images/national_park.jpg',
    isPublic: true,

    photoCount: 6,
    videoCount: 2,
    audioCount: 1,

    description:
        'A refreshing escape from the city surrounded by greenery and nature.',

    companions: ['Rahul'],

    highlights: ['Nature', 'Greenery', 'Walking'],

    audioNote: 'It feels completely different from the rest of Mumbai.',

    notes: 'Great place to spend a few quiet hours away from the city.',

    latitude: 19.2147,
    longitude: 72.9106,

    userName: 'Rahul',
    userProfileImage: 'assets/images/rahul.jpg',

    isFriend: true,
  ),
];
