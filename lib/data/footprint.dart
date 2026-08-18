import '../models/footprint.dart';

final List<Footprint> footprints = [
  Footprint(
    id: 'fp001',
    place: 'Marine Drive, Mumbai',
    date: '10 Aug 2026',
    time: '6:45 PM',
    image:
        'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?auto=format&fit=crop&w=800&q=80',
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
    userProfileImage:
        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
    isFriend: true,
  ),
  Footprint(
    id: 'fp002',
    place: 'Juhu Beach, Mumbai',
    date: '10 Aug 2026',
    time: '5:20 PM',
    image:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
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
    userProfileImage:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80',
    isFriend: true,
  ),
  Footprint(
    id: 'fp003',
    place: 'Gateway of India, Mumbai',
    date: '10 Aug 2026',
    time: '3:15 PM',
    image:
        'https://images.unsplash.com/photo-1566552881560-0be862a7c445?auto=format&fit=crop&w=800&q=80',
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
    date: '08 Aug 2026',
    time: '5:45 PM',
    image:
        'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?auto=format&fit=crop&w=800&q=80',
    isPublic: true,
    photoCount: 6,
    videoCount: 1,
    audioCount: 1,
    description:
        'Caught the sunset overlooking the Bandra-Worli Sea Link from the historic fort.',
    companions: ['Karan', 'Meera'],
    highlights: ['Sea Link', 'Fort View', 'Heritage'],
    audioNote: 'Wind was howling at the top of the ramparts!',
    notes: 'Must visit during golden hour.',
    latitude: 19.0435,
    longitude: 72.8184,
    userName: 'Karan',
    userProfileImage:
        'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?auto=format&fit=crop&w=200&q=80',
    isFriend: true,
  ),
];
