import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/home_data.dart';

class JsonLoader {
  /// Încarcă asincron JSON-ul din assets
  static Future<HomeData> loadHomeData() async {
    // Simulăm o întârziere (ca o cerere de rețea)
    await Future.delayed(const Duration(seconds: 2));

    final jsonString = await rootBundle.loadString('assets/data/lab v2.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;

    return HomeData.fromJson(jsonData);
  }
}