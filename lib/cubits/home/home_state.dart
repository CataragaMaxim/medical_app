import 'package:equatable/equatable.dart';
import '../../models/home_data.dart';
import '../../models/doctor.dart';

// Starea de bază
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

// 1. LOADING
class HomeLoading extends HomeState {
  const HomeLoading();
}

// 2. SUCCESS (cu date)
class HomeSuccess extends HomeState {
  final HomeData data;
  final String searchQuery;
  final String selectedCategory;
  final String sortBy;

  const HomeSuccess({
    required this.data,
    this.searchQuery = '',
    this.selectedCategory = 'All',
    this.sortBy = 'name',
  });

  // Lista filtrată și sortată
  List<Doctor> get filteredDoctors {
    var doctors = data.nearbyDoctors.where((d) {
      // Căutare
      final matchesSearch = searchQuery.isEmpty ||
          d.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          d.specialty.toLowerCase().contains(searchQuery.toLowerCase());

      // Filtrare categorie
      final matchesCategory = selectedCategory == 'All' ||
          d.specialty.toLowerCase().contains(selectedCategory.toLowerCase());

      return matchesSearch && matchesCategory;
    }).toList();

    // Sortare
    switch (sortBy) {
      case 'name':
        doctors.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'distance':
        doctors.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case 'price':
        doctors.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
        break;
    }

    return doctors;
  }

  // Lista de favorite
  List<Doctor> get favorites =>
      data.nearbyDoctors.where((d) => d.isFavorite).toList();

  HomeSuccess copyWith({
    HomeData? data,
    String? searchQuery,
    String? selectedCategory,
    String? sortBy,
  }) {
    return HomeSuccess(
      data: data ?? this.data,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  List<Object> get props => [data, searchQuery, selectedCategory, sortBy];
}

// 3. EMPTY (nu sunt rezultate)
class HomeEmpty extends HomeState {
  const HomeEmpty();
}

// 4. ERROR
class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}