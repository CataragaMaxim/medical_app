import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/doctor.dart';
import '../widgets/doctor_card.dart';
import '../widgets/service_icon.dart';
import 'appointment_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ===== HEADER =====
              _buildHeader(),

              const SizedBox(height: 20),

              // ===== SEARCH BAR =====
              _buildSearchBar(),

              const SizedBox(height: 20),

              // ===== APPOINTMENT CARD =====
              _buildAppointmentCard(context),

              const SizedBox(height: 25),

              // ===== HEALTH SERVICES =====
              _buildSectionHeader('Health Services'),
              const SizedBox(height: 15),
              _buildHealthServices(),

              const SizedBox(height: 25),

              // ===== NEARBY DOCTOR =====
              _buildSectionHeader('Nearby Doctor'),
              const SizedBox(height: 15),
              _buildNearbyDoctors(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Header cu avatar + nume + notificare
  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hi, Jonathan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'May you always be healthy',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.backgroundGrey,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: AppColors.textPrimary,
            size: 22,
          ),
        ),
      ],
    );
  }

  // Bara de căutare
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: const [
          Icon(Icons.search, color: AppColors.textSecondary),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search something',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.tune, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  // Card programare viitoare
  Widget _buildAppointmentCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AppointmentScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Appointment',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    color: AppColors.white, size: 16),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    color: AppColors.white, size: 16),
                const SizedBox(width: 8),
                const Text(
                  '22 October, 2023',
                  style: TextStyle(color: AppColors.white, fontSize: 14),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.videocam,
                      color: AppColors.white, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: const [
                Icon(Icons.access_time,
                    color: AppColors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  '08:00 AM - 10:30 AM',
                  style: TextStyle(color: AppColors.white, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://i.pravatar.cc/150?img=3',
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Dr. Richar Kandowen',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Child Specialist',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.chat_bubble_outline,
                      color: AppColors.primary, size: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header secțiune cu "See All"
  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const Text(
          'See All',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Servicii medicale (Tooth, Eye, Lungs, Ear)
  Widget _buildHealthServices() {
    final services = [
      {'name': 'Tooth', 'icon': Icons.medical_services},
      {'name': 'Eye', 'icon': Icons.remove_red_eye},
      {'name': 'Lungs', 'icon': Icons.favorite},
      {'name': 'Ear', 'icon': Icons.hearing},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: services.map((service) {
        return ServiceIcon(
          name: service['name'] as String,
          icon: service['icon'] as IconData,
        );
      }).toList(),
    );
  }

  // Lista doctori din apropiere
  Widget _buildNearbyDoctors() {
    return Column(
      children: nearbyDoctors.map((doctor) {
        return DoctorCard(doctor: doctor);
      }).toList(),
    );
  }
}