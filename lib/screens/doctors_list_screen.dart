import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/doctor.dart';
import '../widgets/doctor_card.dart';
import 'appointment_screen.dart';

class DoctorsListScreen extends StatelessWidget {
  final List<Doctor> doctors;

  const DoctorsListScreen({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Doctors',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return DoctorCard(
            doctor: doctor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AppointmentScreen(doctor: doctor),
                ),
              );
            },
          );
        },
      ),
    );
  }
}