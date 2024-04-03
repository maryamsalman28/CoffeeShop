import 'package:flutter/material.dart';
import 'package:fluttertest/components/coffee_tile.dart';
import 'package:fluttertest/models/coffee.dart';
import 'package:fluttertest/models/coffee_shop.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State <ShopPage> createState() =>  _ShopPageState();
}

class  _ShopPageState extends State<ShopPage> {

  // Method to show coffee details when clicked
  void showCoffeeDetails(Coffee coffee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 177, 156, 128),
        title: Text(coffee.name),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Price: ${coffee.price}'),
            Text('Caffeine Level: ${coffee.caffeineLevel}'),
            Text('Sugar Level: ${coffee.sugarLevel}'),
            // Add more details here as needed
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  // Method to add coffee to cart
  void addToCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).addItemToCart(coffee);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Successfully added to cart"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) =>SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // Heading message
              const Text(
                "How would you like your coffee?", 
                style: TextStyle(fontSize:23, fontFamily: 'Playball', ),
              ),
              const SizedBox(height: 25),

              // List of coffee to buy
              Expanded(
                child: ListView.builder(
                  itemCount: value.coffeeShop.length,
                  itemBuilder: (context, index){
                    // Get individual coffee
                    Coffee eachCoffee = value.coffeeShop[index];

                    // Return the tile for this coffee with onTap to show details
                    return InkWell(
                      onTap: () => showCoffeeDetails(eachCoffee),
                      child: CoffeeTile(
                        coffee: eachCoffee,
                        icon: Icon(Icons.add),
                        onPressed: () => addToCart(eachCoffee),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
