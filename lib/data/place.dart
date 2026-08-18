import '../models/place.dart';

final Place defaultPlace = Place(
  id: 'place_mumbai',
  name: 'Mumbai',
  tagline: 'Near your current location',
  category: 'City & Coastal Hub',
  city: 'Mumbai, Maharashtra',
  address: 'Mumbai Coastal Region, India',
  latitude: 18.9431,
  longitude: 72.8236,
  heroImage:
      'https://images.unsplash.com/photo-1595658658481-d53d3f999875?auto=format&fit=crop&w=1200&q=80',
  galleryImages: [
    'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?auto=format&fit=crop&w=800&q=80',
    'https://images.unsplash.com/photo-1566552881560-0be862a7c445?auto=format&fit=crop&w=800&q=80',
  ],
  about:
      "Mumbai is India's financial capital and one of the country's most vibrant coastal cities. Famous for its dreams, culture, nightlife and iconic landmarks.",
  history:
      "Originally a cluster of seven islands, Mumbai has a rich colonial history and has grown into the heart of India's economy, arts and entertainment.",
  rating: 4.8,
  reviewCount: 1420,
  weatherTemp: '28°C',
  weatherCondition: 'Sunny / Coastal',
  bestTime: 'Oct - Mar',
  totalFootprints: 342,
);

final List<Place> mockPlaces = [
  defaultPlace,
  Place(
    id: 'place_marine_drive',
    name: 'Marine Drive',
    tagline: "The Queen's Necklace",
    category: 'Promenade & Sunset',
    city: 'South Mumbai',
    address: 'Netaji Subhash Chandra Bose Road, Mumbai',
    latitude: 18.9431,
    longitude: 72.8236,
    heroImage:
        'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?auto=format&fit=crop&w=1200&q=80',
    about:
        'A 3.6-kilometre-long boulevard in South Mumbai. A famous spot for watching the Arabian Sea sunset and taking night strolls.',
    history:
        'Constructed as part of the Back Bay Reclamation Scheme in the late 19th and early 20th century.',
    rating: 4.9,
    reviewCount: 980,
    weatherTemp: '27°C',
    weatherCondition: 'Breezy',
    bestTime: 'Evenings (5 PM - 8 PM)',
    totalFootprints: 215,
  ),
  Place(
    id: 'place_gateway',
    name: 'Gateway of India',
    tagline: 'Historical Waterfront Monument',
    category: 'Historical Landmark',
    city: 'South Mumbai',
    address: 'Apollo Bandar, Colaba, Mumbai',
    latitude: 18.9220,
    longitude: 72.8347,
    heroImage:
        'https://images.unsplash.com/photo-1566552881560-0be862a7c445?auto=format&fit=crop&w=1200&q=80',
    about:
        'An iconic arch monument overlooking the Arabian Sea, visited by millions of travellers every year.',
    history:
        'Erected to commemorate the landing of King George V and Queen Mary at Apollo Bunder in 1911.',
    rating: 4.7,
    reviewCount: 1650,
    weatherTemp: '29°C',
    weatherCondition: 'Sunny',
    bestTime: 'Morning or Sunset',
    totalFootprints: 189,
  ),
  Place(
    id: 'place_juhu',
    name: 'Juhu Beach',
    tagline: 'Lively Coast & Famous Street Food',
    category: 'Beach & Culture',
    city: 'Western Suburbs, Mumbai',
    address: 'Juhu Tara Rd, Juhu, Mumbai',
    latitude: 19.0988,
    longitude: 72.8268,
    heroImage:
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1200&q=80',
    about:
        'One of the most famous beaches in India, known for delicious Mumbai street food like Pav Bhaji and Bhel Puri.',
    history:
        'A historic coastal suburb favored by artists, actors, and locals for weekend getaways.',
    rating: 4.5,
    reviewCount: 740,
    weatherTemp: '30°C',
    weatherCondition: 'Warm & Breezy',
    bestTime: 'Evening (4 PM - 7 PM)',
    totalFootprints: 140,
  ),
  Place(
    id: 'place_bandra_fort',
    name: 'Bandra Fort',
    tagline: 'Castella de Aguada & Sea Link View',
    category: 'Heritage & Scenic View',
    city: 'Bandra West, Mumbai',
    address: 'Byramji Jeejeebhoy Road, Bandstand, Mumbai',
    latitude: 19.0435,
    longitude: 72.8184,
    heroImage:
        'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?auto=format&fit=crop&w=1200&q=80',
    about:
        'A historic fort offering picturesque panoramic views of the Arabian Sea and the Bandra-Worli Sea Link.',
    history:
        'Built by the Portuguese in 1640 as a watchtower overlooking Mahim Bay.',
    rating: 4.6,
    reviewCount: 520,
    weatherTemp: '28°C',
    weatherCondition: 'Windy',
    bestTime: 'Sunset (5:30 PM)',
    totalFootprints: 95,
  ),
];
