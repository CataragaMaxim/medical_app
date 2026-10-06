import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/doctor.dart';
import '../widgets/doctor_card.dart';
import '../widgets/empty_widget.dart';
import 'appointment_screen.dart';

class DoctorsListScreen extends StatefulWidget {
  final List<Doctor> doctors;

  const DoctorsListScreen({super.key, required this.doctors});

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  late List<Doctor> _doctors;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _doctors = List.from(widget.doctors);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Doctor> get _filteredDoctors {
    if (_searchQuery.isEmpty) return _doctors;
    return _doctors.where((d) {
      return d.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d.specialty.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _toggleFavorite(String doctorId) {
    setState(() {
      _doctors = _doctors.map((d) {
        if (d.id == doctorId) {
          return d.copyWith(isFavorite: !d.isFavorite);
        }
        return d;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredDoctors;

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
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
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
                        hintText: 'Search doctors...',
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Lista
          Expanded(
            child: filtered.isEmpty
                ? const EmptyWidget(
              message: 'No doctors found',
              icon: Icons.person_off,
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final doctor = filtered[index];
                return DoctorCard(
                  doctor: doctor,
                  onFavoriteToggle: () => _toggleFavorite(doctor.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AppointmentScreen(doctor: doctor),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}