class HealthService {
  final String id;
  final String name;
  final String iconUrl;

  const HealthService({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  factory HealthService.fromJson(Map<String, dynamic> json) {
    return HealthService(
      id: json['id'] as String,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
    );
  }
}