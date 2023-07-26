import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/url.dart';
import 'models/api_datamodel.dart';

class ApiService {
  static Future<APIDataModel> fetchBeers({offset}) async {
    final url = Uri.parse('$baseUrl?offset=${offset}&limit=10');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return APIDataModel.fromJson(data);
    } else {
      throw Exception('Failed to load beers');
    }
  }
}
