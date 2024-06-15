import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertest/models/coffee.dart';

class LocalStorageService {
  static const String key = 'coffees';

  static Future<void> saveCoffees(List<Coffee> coffees) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> jsonCoffees = coffees.map((coffee) => json.encode(coffee.toJson())).toList();
      await prefs.setStringList(key, jsonCoffees);
    } catch (e) {
      print('Error saving coffees: $e');
    }
  }

  static Future<List<Coffee>> loadCoffees() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? jsonCoffees = prefs.getStringList(key);
      if (jsonCoffees != null) {
        return jsonCoffees.map((jsonCoffee) => Coffee.fromJson(json.decode(jsonCoffee))).toList();
      } else {
        print('No coffees found in local storage');
        return [];
      }
    } catch (e) {
      print('Error loading coffees: $e');
      return [];
    }
  }
}
