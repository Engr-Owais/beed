import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/beer_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.punkapi.com/v2/beers';

  static Future<List<BeerModel>> fetchBeers({int? page , int perPage = 10}) async {
    final url = Uri.parse('$baseUrl?page=$page&per_page=$perPage');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => BeerModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load beers');
    }
  }
}
