import 'package:flutter/material.dart';
import 'package:fluttertest/models/coffee.dart';
import 'package:fluttertest/services/api_service.dart';
import 'package:fluttertest/services/local_storage_service.dart';
import 'package:fluttertest/services/connectivity_service.dart';

class CoffeeShop extends ChangeNotifier {
  List<Coffee> _shop = [];

  final List<Coffee> _usercart = [];

  List<Coffee> get coffeeShop => _shop;

  List<Coffee> get userCart => _usercart;

  void addItemToCart(Coffee coffee) {
    _usercart.add(coffee);
    notifyListeners();
  }

  void removeItemFromCart(Coffee coffee) {
    _usercart.remove(coffee);
    notifyListeners();
  }

  Future<void> fetchAndLoadCoffees() async {
    bool connected = await ConnectivityService.isConnected();
    print('Network connected: $connected'); // Debug statement
    try {
      if (connected) {
        _shop = await ApiService.fetchCoffees();
        await LocalStorageService.saveCoffees(_shop);
      } else {
        _shop = await LocalStorageService.loadCoffees();
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching and loading coffees: $e');
      _shop = await LocalStorageService.loadCoffees();
      notifyListeners();
    }
  }
}
