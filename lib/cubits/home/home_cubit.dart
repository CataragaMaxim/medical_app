import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/json_loader.dart';
import '../../models/home_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeLoading());

  Future<void> loadData() async {
    emit(const HomeLoading());
    try {
      final data = await JsonLoader.loadHomeData();
      emit(HomeSuccess(data: data));
    } catch (e) {
      emit(HomeError('Eroare la încărcare: $e'));
    }
  }

  Future<void> refresh() async {
    await loadData();
  }

  void search(String query) {
    final currentState = state;
    if (currentState is HomeSuccess) {
      emit(currentState.copyWith(searchQuery: query));
    }
  }

  void filterByCategory(String category) {
    final currentState = state;
    if (currentState is HomeSuccess) {
      emit(currentState.copyWith(selectedCategory: category));
    }
  }

  void sortBy(String sortBy) {
    final currentState = state;
    if (currentState is HomeSuccess) {
      emit(currentState.copyWith(sortBy: sortBy));
    }
  }

  void toggleFavorite(String doctorId) {
    final currentState = state;
    if (currentState is HomeSuccess) {
      final updatedDoctors = currentState.data.nearbyDoctors.map((d) {
        if (d.id == doctorId) {
          return d.copyWith(isFavorite: !d.isFavorite);
        }
        return d;
      }).toList();

      final updatedData = HomeData(
        user: currentState.data.user,
        hasUnreadNotifications: currentState.data.hasUnreadNotifications,
        searchHint: currentState.data.searchHint,
        appointment: currentState.data.appointment,
        appointmentDoctor: currentState.data.appointmentDoctor,  // ← NOU
        healthServices: currentState.data.healthServices,
        nearbyDoctors: updatedDoctors,
      );

      emit(currentState.copyWith(data: updatedData));
    }
  }

  void clearFavorites() {
    final currentState = state;
    if (currentState is HomeSuccess) {
      final updatedDoctors = currentState.data.nearbyDoctors
          .map((d) => d.copyWith(isFavorite: false))
          .toList();

      final updatedData = HomeData(
        user: currentState.data.user,
        hasUnreadNotifications: currentState.data.hasUnreadNotifications,
        searchHint: currentState.data.searchHint,
        appointment: currentState.data.appointment,
        appointmentDoctor: currentState.data.appointmentDoctor,  // ← NOU
        healthServices: currentState.data.healthServices,
        nearbyDoctors: updatedDoctors,
      );

      emit(currentState.copyWith(data: updatedData));
    }
  }
}