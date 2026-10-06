import 'doctor.dart';

class Appointment {
  final String title;
  final String date;
  final String time;
  final Doctor doctor;

  const Appointment({
    required this.title,
    required this.date,
    required this.time,
    required this.doctor,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      title: json['title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      doctor: Doctor.fromJson({
        'id': 'appointment-doctor',
        'name': json['doctor']['name'],
        'specialty': json['doctor']['specialty'],
        'distance': '',
        'avatarUrl': json['doctor']['avatarUrl'],
      }),
    );
  }
}