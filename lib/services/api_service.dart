import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertest/models/coffee.dart';

class ApiService {
  static const String apiUrl = 'https://api.sampleapis.com/coffee/hot';

  static Future<List<Coffee>> fetchCoffees() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        print('API Response: $jsonResponse'); // Debug statement
        return jsonResponse.map((coffee) => Coffee.fromJson(coffee)).toList();
      } else {
        print('Failed to load coffees: ${response.statusCode}');
        throw Exception('Failed to load coffees: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
