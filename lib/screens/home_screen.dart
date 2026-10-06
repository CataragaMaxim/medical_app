import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme.dart';
import '../cubits/home/home_cubit.dart';
import '../cubits/home/home_state.dart';
import '../widgets/doctor_card.dart';
import '../widgets/service_icon.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/empty_widget.dart';
import 'appointment_screen.dart';
import 'doctors_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

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
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            // 1. LOADING
            if (state is HomeLoading) {
              return const LoadingWidget(message: 'Loading your data...');
            }

            // 2. ERROR
            if (state is HomeError) {
              return ErrorDisplayWidget(
                message: state.message,
                onRetry: () => context.read<HomeCubit>().loadData(),
              );
            }

            // 3. SUCCESS
            if (state is HomeSuccess) {
              return _buildSuccessContent(state);
            }

            // 4. EMPTY (fallback)
            return const EmptyWidget();
          },
        ),
      ),
    );
  }

  Widget _buildSuccessContent(HomeSuccess state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          // HEADER
          _buildHeader(state),

          const SizedBox(height: 20),

          // SEARCH BAR
          _buildSearchBar(state),

          const SizedBox(height: 20),

          // APPOINTMENT CARD
          _buildAppointmentCard(state),

          const SizedBox(height: 25),

          // HEALTH SERVICES
          _buildSectionHeader('Health Services'),
          const SizedBox(height: 15),
          _buildHealthServices(state),

          const SizedBox(height: 25),

          // NEARBY DOCTORS
          _buildSectionHeader(
            'Nearby Doctor',
            onSeeAll: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DoctorsListScreen(
                    doctors: state.filteredDoctors,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 15),
          _buildNearbyDoctors(state),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============ HEADER ============
  Widget _buildHeader(HomeSuccess state) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(state.data.user.avatarUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.data.user.greeting,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                state.data.user.subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        // Refresh button + Notifications
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.refresh, color: AppColors.textSecondary),
              onPressed: () => context.read<HomeCubit>().refresh(),
            ),
            Stack(
              children: [
                const Icon(Icons.notifications_outlined,
                    color: AppColors.textPrimary, size: 26),
                if (state.data.hasUnreadNotifications)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.background,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ============ SEARCH BAR ============
  Widget _buildSearchBar(HomeSuccess state) {
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
                context.read<HomeCubit>().search(value);
              },
              decoration: InputDecoration(
                hintText: state.data.searchHint,
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none,
              ),
            ),
          ),
          // Sortare
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort, color: AppColors.textSecondary),
            onSelected: (value) {
              context.read<HomeCubit>().sortBy(value);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'name', child: Text('Sort by name')),
              PopupMenuItem(value: 'distance', child: Text('Sort by distance')),
              PopupMenuItem(value: 'price', child: Text('Sort by price')),
            ],
          ),
        ],
      ),
    );
  }

  // ============ APPOINTMENT CARD ============
  Widget _buildAppointmentCard(HomeSuccess state) {
    final appointment = state.data.appointment;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AppointmentScreen(
              doctor: state.data.appointmentDoctor,   // ← Dr. Upul!
            ),
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
                Text(
                  appointment.date,
                  style: const TextStyle(color: AppColors.white, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.access_time,
                    color: AppColors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  appointment.time,
                  style: const TextStyle(color: AppColors.white, fontSize: 14),
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
                      appointment.doctor.avatarUrl,
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctor.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        appointment.doctor.specialty,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
        if (onSeeAll != null)
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
  Widget _buildHealthServices(HomeSuccess state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: state.data.healthServices.map((service) {
        final isSelected = state.selectedCategory == service.name;
        return ServiceIcon(
          name: service.name,
          iconUrl: service.iconUrl,
          isSelected: isSelected,
          onTap: () {
            context.read<HomeCubit>().filterByCategory(
              isSelected ? 'All' : service.name,
            );
          },
        );
      }).toList(),
    );
  }

  // ============ NEARBY DOCTORS ============
  Widget _buildNearbyDoctors(HomeSuccess state) {
    final doctors = state.filteredDoctors;

    // EMPTY state
    if (doctors.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: EmptyWidget(message: 'No doctors found'),
      );
    }

    return Column(
      children: doctors.map((doctor) {
        return DoctorCard(
          doctor: doctor,
          onFavoriteToggle: () {
            context.read<HomeCubit>().toggleFavorite(doctor.id);
          },
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