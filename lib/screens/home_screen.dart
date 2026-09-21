import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/doctor.dart';
import '../widgets/doctor_card.dart';
import '../widgets/service_icon.dart';
import 'appointment_screen.dart';
import 'doctors_list_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Stare pentru căutare și filtrare
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  // Filtrare doctori
  List<Doctor> get _filteredDoctors {
    return allDoctors.where((doctor) {
      final matchesSearch = _searchQuery.isEmpty ||
          doctor.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          doctor.specialty.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' ||
          doctor.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildAppointmentCard(context),
              const SizedBox(height: 25),
              _buildSectionHeader(
                'Health Services',
                onSeeAll: () {
                  setState(() {
                    _selectedCategory = 'All';
                  });
                },
              ),
              const SizedBox(height: 15),
              _buildHealthServices(),
              const SizedBox(height: 25),
              _buildSectionHeader(
                'Nearby Doctor',
                onSeeAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DoctorsListScreen(doctors: allDoctors),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildNearbyDoctors(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============ HEADER ============
  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _showProfileDialog(),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: const AssetImage('assets/images/profile.jpg'),
          ),
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
        // Buton notificări funcțional
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NotificationsScreen(),
              ),
            );
          },
          child: Stack(
            children: [
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
              // Badge notificări
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(width: 12),
            const Text('Jonathan Smith'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('📧 jonathan@email.com'),
            SizedBox(height: 8),
            Text('📱 +1 234 567 890'),
            SizedBox(height: 8),
            Text('🎂 15 March 1990'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  // ============ SEARCH BAR ============
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.backgroundGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search something',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none,
              ),
            ),
          ),
          // Buton filtrare
          GestureDetector(
            onTap: _showFilterDialog,
            child: const Icon(Icons.tune, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter by category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 10,
              children: ['All', 'General', 'Tooth', 'Eye', 'Lungs', 'Ear']
                  .map((cat) {
                return ChoiceChip(
                  label: Text(cat),
                  selected: _selectedCategory == cat,
                  onSelected: (_) {
                    setState(() {
                      _selectedCategory = cat;
                    });
                    Navigator.pop(context);
                  },
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: _selectedCategory == cat
                        ? AppColors.white
                        : AppColors.textPrimary,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ============ APPOINTMENT CARD ============
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
              children: const [
                Text(
                  'Appointment',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
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
                // Buton video call funcțional
                GestureDetector(
                  onTap: () => _showVideoCallDialog(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.videocam,
                        color: AppColors.white, size: 20),
                  ),
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
                    child: Image.asset(
                      'assets/images/doctor3.jpg',
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
                  // Buton chat funcțional
                  GestureDetector(
                    onTap: () => _showChatDialog(),
                    child: const Icon(Icons.chat_bubble_outline,
                        color: AppColors.primary, size: 22),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVideoCallDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Video Call'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: const AssetImage('assets/images/doctor3.jpg'),
            ),
            const SizedBox(height: 15),
            const Text('Calling Dr. Richar Kandowen...'),
            const SizedBox(height: 15),
            const CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'End Call',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showChatDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/doctor3.jpg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Dr. Richar Kandowen',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: [
                    _chatBubble('Hello! How can I help you?', false),
                    _chatBubble('I have a question about my child', true),
                    _chatBubble('Sure, please tell me more', false),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: AppColors.white, size: 20),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatBubble(String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : AppColors.backgroundGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  // ============ SECTION HEADER ============
  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
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
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // ============ HEALTH SERVICES ============
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
        final isSelected = _selectedCategory == service['name'];
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = isSelected ? 'All' : service['name'] as String;
            });
            // Scroll la doctori
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Filter: ${service['name']}'),
                backgroundColor: AppColors.primary,
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: ServiceIcon(
            name: service['name'] as String,
            icon: service['icon'] as IconData,
            isSelected: isSelected,
          ),
        );
      }).toList(),
    );
  }

  // ============ NEARBY DOCTORS ============
  Widget _buildNearbyDoctors() {
    final doctors = _filteredDoctors;

    if (doctors.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            'No doctors found',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return Column(
      children: doctors.map((doctor) {
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
      }).toList(),
    );
  }
}