class Appointment {
  final String doctorName;
  final String specialty;
  final String doctorImage;
  final String date;
  final String time;
  final double payment;
  final String type; // 'video', 'chat', 'phone'

  Appointment({
    required this.doctorName,
    required this.specialty,
    required this.doctorImage,
    required this.date,
    required this.time,
    required this.payment,
    required this.type,
  });
}