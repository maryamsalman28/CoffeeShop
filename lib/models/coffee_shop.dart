import 'package:flutter/material.dart';

import 'coffee.dart';

class CoffeeShop extends ChangeNotifier {

  //coffee for sale list
  final List<Coffee> _shop = [
    //black coffee
    Coffee(
      name: 'Long Black',
      price: "Rs. 500",
      imagePath: "lib/images/coffee.png",
      caffeineLevel: "High",
      sugarLevel: "Low",
    ),

    //latte
    Coffee(
      name: 'Latte',
      price: "Rs. 700",
      imagePath: "lib/images/latte-art.png",
      caffeineLevel: "Medium",
      sugarLevel: "Medium",
    ),

    //espresso
    Coffee(
      name: 'Espresso',
      price: "Rs. 350",
      imagePath: "lib/images/expresso.png",
      caffeineLevel: "High",
      sugarLevel: "Low",
    ),

    //iced coffee
    Coffee(
      name: 'Iced Coffee',
      price: "Rs. 650",
      imagePath: "lib/images/ice-coffee.png",
      caffeineLevel: "Low",
      sugarLevel: "High",
    ),

    //cappuccino
    Coffee(
      name: 'Cappuccino',
      price: "Rs. 550",
      imagePath: "lib/images/cappuccino.png",
      caffeineLevel: "Medium",
      sugarLevel: "Medium",
    ),

    //americano
    Coffee(
      name: 'Americano',
      price: "Rs. 600",
      imagePath: "lib/images/americano.png",
      caffeineLevel: "High",
      sugarLevel: "Low",
    ),
  ];

  

  //user cart
  final List<Coffee> _usercart = [];

  //get coffee list
  List<Coffee> get coffeeShop => _shop;

  //get user cart
  List<Coffee> get userCart => _usercart;

  get isDarkMode => null;

  //add item to cart
  void addItemToCart(Coffee coffee){
    _usercart.add(coffee);
    notifyListeners();
  }

  //remove item from cart
void removeItemFromCart(Coffee coffee){
  _usercart.remove(coffee);
  notifyListeners();
}

  void setDarkMode(bool value) {}

  

}