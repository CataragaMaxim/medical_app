import 'appointment.dart';
import 'doctor.dart';
import 'health_service.dart';

class User {
  final String name;
  final String greeting;
  final String subtitle;
  final String avatarUrl;

  const User({
    required this.name,
    required this.greeting,
    required this.subtitle,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      greeting: json['greeting'] as String,
      subtitle: json['subtitle'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );
  }
}

class HomeData {
  final User user;
  final bool hasUnreadNotifications;
  final String searchHint;
  final Appointment appointment;
  final Doctor appointmentDoctor;        // ← NOU: Dr. Upul din appointmentDetails
  final List<HealthService> healthServices;
  final List<Doctor> nearbyDoctors;

  const HomeData({
    required this.user,
    required this.hasUnreadNotifications,
    required this.searchHint,
    required this.appointment,
    required this.appointmentDoctor,      // ← NOU
    required this.healthServices,
    required this.nearbyDoctors,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    final homeScreen = json['homeScreen'] as Map<String, dynamic>;
    final appointmentDetails = json['appointmentDetails'] as Map<String, dynamic>;

    return HomeData(
      user: User.fromJson(homeScreen['user'] as Map<String, dynamic>),
      hasUnreadNotifications:
      homeScreen['notifications']['hasUnread'] as bool? ?? false,
      searchHint: homeScreen['search']['hint'] as String,
      appointment:
      Appointment.fromJson(homeScreen['appointment'] as Map<String, dynamic>),

      // ✅ Citim Dr. Upul din appointmentDetails
      appointmentDoctor: Doctor(
        id: 'dr-upul',
        name: appointmentDetails['doctor']['name'] as String,
        specialty: appointmentDetails['doctor']['clinic'] as String,
        distance: '',
        avatarUrl: appointmentDetails['doctor']['avatarUrl'] as String,
        price: (appointmentDetails['payment']['amount'] as num).toDouble(),
      ),

      healthServices: (homeScreen['healthServices'] as List)
          .map((e) => HealthService.fromJson(e as Map<String, dynamic>))
          .toList(),
      nearbyDoctors: (homeScreen['nearbyDoctors'] as List)
          .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}