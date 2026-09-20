import 'package:flutter/material.dart';
import '../theme.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  // Stări pentru selecții
  int _selectedHourIndex = 1;  // 11:00 AM selectat
  int _selectedDateIndex = 0;  // Sun 4 selectat

  final List<String> _hours = ['10:00 AM', '11:00 AM', '12:00 PM'];
  final List<String> _dates = ['Sun 4', 'Mon 5', 'Tue 6'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Appointment',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== DOCTOR INFO =====
              _buildDoctorInfo(),

              const SizedBox(height: 20),

              // ===== PAYMENT =====
              _buildPayment(),

              const SizedBox(height: 25),

              // ===== DETAILS =====
              _buildDetails(),

              const SizedBox(height: 25),

              // ===== WORKING HOURS =====
              _buildWorkingHours(),

              const SizedBox(height: 20),

              // ===== DATE =====
              _buildDate(),

              const SizedBox(height: 30),

              // ===== BUTON =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Appointment booked!'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                  child: const Text(
                    'Book an Appointment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Info doctor (foto + nume + iconițe acțiuni)
  Widget _buildDoctorInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            'https://i.pravatar.cc/150?img=11',
            width: 90,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dr.Upul',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'Denteeth',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildActionIcon(Icons.chat_bubble_outline),
                  const SizedBox(width: 8),
                  _buildActionIcon(Icons.phone_outlined),
                  const SizedBox(width: 8),
                  _buildActionIcon(Icons.videocam_outlined),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Iconiță rotundă pentru acțiuni (chat, phone, video)
  Widget _buildActionIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.primary, size: 18),
    );
  }

  // Secțiune plată
  Widget _buildPayment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Payment',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const Text(
          '\$120.00',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  // Detalii (text descriptiv)
  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Worem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Nunc vulputate libero et velit interdum, ac aliquet odio mattis. '
              'Class aptent taciti sociosqu ad litora torquent per conubia nostra, '
              'per inceptos himenaeos. Curabitur tempus urna at turpis condimentum '
              'lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis '
              'condimentum ac, vestibulum eu nisl.',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // Program de lucru (ore)
  Widget _buildWorkingHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Working Hours',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(_hours.length, (index) {
            final isSelected = index == _selectedHourIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedHourIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                    right: index < _hours.length - 1 ? 10 : 0,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.backgroundGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _hours[index],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // Selectare dată
  Widget _buildDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(_dates.length, (index) {
            final isSelected = index == _selectedDateIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDateIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                    right: index < _dates.length - 1 ? 10 : 0,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.backgroundGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _dates[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}