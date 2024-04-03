import 'package:flutter/material.dart';
import 'package:fluttertest/components/coffee_tile.dart';
import 'package:fluttertest/models/coffee.dart';
import 'package:fluttertest/models/coffee_shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Remove item from cart
  void removeFromCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).removeItemFromCart(coffee);
  }

  // Pay button tapped
  void payNow() {
    // Fill out your payment service here
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // Heading
              Text(
                'Your Cart',
                style: TextStyle(
                  fontSize: 25, 
                  fontFamily: 'Playball', 
                  fontWeight: FontWeight.bold,),
              ),

              // Check if cart is empty
              value.userCart.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'Your cart is empty.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  : Expanded(
                      // List of cart items
                      child: ListView.builder(
                        itemCount: value.userCart.length,
                        itemBuilder: (context, index) {
                          // Get individual cart items
                          Coffee eachCoffee = value.userCart[index];

                          // Return coffee tile
                          return CoffeeTile(
                            coffee: eachCoffee,
                            onPressed: () => removeFromCart(eachCoffee),
                            icon: Icon(Icons.delete),
                          );
                        },
                      ),
                    ),

              // Pay button
              GestureDetector(
                onTap: payNow,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Pay Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}