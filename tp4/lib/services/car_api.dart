import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car.dart';

class CarApiService {
  // Using the provided Auto.dev listings endpoint with API key
  static const String _listingsUrl =
      'https://auto.dev/api/listings?apiKey=sk_ad_KTpyopFeRuwqv4Pb0ZU_0hif';

  Future<List<Car>> fetchCars() async {
    try {
      final uri = Uri.parse(_listingsUrl);
      final resp = await http.get(uri);
      if (resp.statusCode != 200) {
        throw Exception('Failed to load listings (${resp.statusCode})');
      }
      final data = jsonDecode(resp.body);
      final dynamic listings = (data is Map && data['records'] is List)
          ? data['records']
          : (data is List)
              ? data
              : (data['listings'] ?? data['results'] ?? data['data']);
      if (listings is List) {
        return listings
            .whereType<Map<String, dynamic>>()
            .map((e) => Car.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load cars: $e');
    }
  }
}
