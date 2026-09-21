class Doctor {
  final String name;
  final String specialty;
  final String imageUrl;
  final String distance;
  final String location;
  final double rating;
  final int reviews;
  final double price;
  final String category; // 'Tooth', 'Eye', 'Lungs', 'Ear', 'General'

  Doctor({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.distance,
    required this.location,
    this.rating = 4.8,
    this.reviews = 120,
    this.price = 120.0,
    this.category = 'General',
  });
}

// Lista extinsă de doctori
final List<Doctor> allDoctors = [
  Doctor(
    name: 'Dr. Figo Vii',
    specialty: 'General Practitioner',
    imageUrl: 'assets/images/doctor1.jpg',
    distance: '3167 Durgan Shores - 500M from you',
    location: '500M',
    rating: 4.9,
    reviews: 245,
    price: 100.0,
    category: 'General',
  ),
  Doctor(
    name: 'Dr. Hreno Vii',
    specialty: 'Dental Specialist',
    imageUrl: 'assets/images/doctor3.jpg',
    distance: '950 Sigrd Port - 753M from you',
    location: '753M',
    rating: 4.7,
    reviews: 189,
    price: 150.0,
    category: 'Tooth',
  ),
  Doctor(
    name: 'Dr. Walter Wait',
    specialty: 'Child Specialist',
    imageUrl: 'assets/images/doctor2.jpg',
    distance: '120 Market St - 1.2km from you',
    location: '1.2km',
    rating: 4.8,
    reviews: 312,
    price: 120.0,
    category: 'General',
  ),
  Doctor(
    name: 'Dr. Iaikin Pensioner',
    specialty: 'Denteeth',
    imageUrl: 'assets/images/doctor4.jpg',
    distance: '45 Dental Ave - 800M from you',
    location: '800M',
    rating: 4.9,
    reviews: 421,
    price: 120.0,
    category: 'Tooth',
  ),
  Doctor(
    name: 'Dr. Hannibal Lectore',
    specialty: 'Eye Specialist',
    imageUrl: 'assets/images/doctor5.jpg',
    distance: '78 Vision Rd - 2.1km from you',
    location: '2.1km',
    rating: 4.6,
    reviews: 156,
    price: 130.0,
    category: 'Eye',
  ),
  Doctor(
    name: 'Dr. Gordon Freeman',
    specialty: 'Pulmonologist',
    imageUrl: 'assets/images/doctor6.jpg',
    distance: '12 Breath St - 3.4km from you',
    location: '3.4km',
    rating: 4.8,
    reviews: 203,
    price: 140.0,
    category: 'Lungs',
  ),
];