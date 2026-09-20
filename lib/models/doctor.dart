class Doctor {
  final String name;
  final String specialty;
  final String imageUrl;
  final String distance;
  final String? location;

  Doctor({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.distance,
    this.location,
  });
}

// Datele pentru doctorii din aplicație
final List<Doctor> nearbyDoctors = [
  Doctor(
    name: 'Dr. Emmly Lestiryno',
    specialty: 'General Practitioner',
    imageUrl: 'https://i.pravatar.cc/150?img=1',
    distance: '3167 Durgan Shores - 500M from you',
    location: '500M',
  ),
  Doctor(
    name: 'Dr. Sonja Littel',
    specialty: 'Dental Specialist',
    imageUrl: 'https://i.pravatar.cc/150?img=5',
    distance: '950 Sigrd Port - 753M from you',
    location: '753M',
  ),
];