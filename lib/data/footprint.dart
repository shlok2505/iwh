import '../models/footprint.dart';

final List<Footprint> footprints = [
  Footprint(
    id: '1',
    place: 'Kedarnath',
    date: '12 Jun 2025',
    time: '08:45 AM',
    image: 'https://images.unsplash.com/photo-1548013146-72479768bada?w=800',
    isPublic: true,

    photoCount: 12,
    videoCount: 2,
    audioCount: 1,

    description:
        'The most divine and challenging journey of my life. The mountains, the cold and the vibes made this journey unforgettable.',

    companions: ['Rishav', 'Manav', 'Suryansh', 'Aman'],

    highlights: ['Trekking', 'Temple Visit', 'Photography', 'Meditation'],

    audioNote: 'My memories from the trek...',

    notes:
        'Started the trek at 4:00 AM. Weather was very cold. Reached the temple at 8:45 AM.',
  ),

  Footprint(
    id: '2',
    place: 'Varanasi',
    date: '28 May 2025',
    time: '06:30 PM',
    image: 'https://images.unsplash.com/photo-1561361058-c24cecae35ca?w=800',
    isPublic: true,

    photoCount: 18,
    videoCount: 3,
    audioCount: 2,

    description:
        'A beautiful evening at the ghats of Varanasi. The atmosphere during Ganga Aarti was unforgettable.',

    companions: ['Rishav', 'Aman'],

    highlights: ['Ganga Aarti', 'Photography', 'Exploring'],

    audioNote: 'Ganga Aarti recording',

    notes:
        'Reached the ghats around sunset and spent the evening exploring Varanasi.',
  ),

  Footprint(
    id: '3',
    place: 'Lonavala',
    date: '10 May 2025',
    time: '11:20 AM',
    image: 'https://images.unsplash.com/photo-1593693411515-c20261bcad6e?w=800',
    isPublic: false,

    photoCount: 15,
    videoCount: 1,
    audioCount: 0,

    description:
        'A peaceful escape into the hills with waterfalls, greenery and lots of fun.',

    companions: ['Manav', 'Suryansh'],

    highlights: ['Trekking', 'Waterfall', 'Photography'],

    notes: 'Perfect weather and an amazing day.',
  ),

  Footprint(
    id: '4',
    place: 'Jaipur',
    date: '05 May 2025',
    time: '04:15 PM',
    image: 'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=800',
    isPublic: true,

    photoCount: 20,
    videoCount: 2,
    audioCount: 1,

    description:
        'Exploring the beautiful architecture and history of the Pink City.',

    companions: ['Rishav', 'Aman', 'Manav'],

    highlights: ['Heritage', 'Photography', 'Food'],

    audioNote: 'Thoughts from Jaipur',

    notes: 'Visited Hawa Mahal and City Palace.',
  ),

  Footprint(
    id: '5',
    place: 'Goa',
    date: '20 Apr 2025',
    time: '09:10 AM',
    image: 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=800',
    isPublic: true,

    photoCount: 14,
    videoCount: 2,
    audioCount: 0,

    description:
        'A relaxing beach trip filled with sunsets, food and good memories.',

    companions: ['Suryansh', 'Aman'],

    highlights: ['Beach', 'Sunset', 'Food'],

    notes: 'Spent the morning at the beach.',
  ),

  Footprint(
    id: '6',
    place: 'Nainital',
    date: '15 Apr 2025',
    time: '07:00 PM',
    image: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800',
    isPublic: false,

    photoCount: 10,
    videoCount: 1,
    audioCount: 1,

    description:
        'A calm mountain getaway surrounded by beautiful lakes and hills.',

    companions: ['Manav'],

    highlights: ['Lake', 'Mountains', 'Boating'],

    audioNote: 'Lake-side recording',

    notes: 'Went boating in the evening.',
  ),
];
