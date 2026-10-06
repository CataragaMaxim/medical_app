class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String distance;
  final String avatarUrl;
  final bool isFavorite;
  final String? clinic;
  final double? price;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.distance,
    required this.avatarUrl,
    this.isFavorite = false,
    this.clinic,
    this.price,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      name: json['name'] as String,
      specialty: json['specialty'] as String? ?? 'Denteeth',
      distance: json['distance'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      clinic: json['clinic'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );
  }

  Doctor copyWith({bool? isFavorite}) {
    return Doctor(
      id: id,
      name: name,
      specialty: specialty,
      distance: distance,
      avatarUrl: avatarUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      clinic: clinic,
      price: price,
    );
  }
}