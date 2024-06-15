import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertest/components/coffee_tile.dart';
import 'package:fluttertest/models/coffee.dart';
import 'package:fluttertest/models/coffee_shop.dart';
import 'package:fluttertest/quote_service.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Quote? _quote;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
      _fetchQuote(); // Fetch the quote when the page loads
    });
  }

  Future<void> _fetchData() async {
    try {
      await Provider.of<CoffeeShop>(context, listen: false).fetchAndLoadCoffees();
    } catch (e) {
      print('Failed to fetch and load coffees: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data. Please try again.')),
      );
    }
  }

  Future<void> _fetchQuote() async {
    try {
      final quoteService = QuoteService();
      final quote = await quoteService.fetchQuote();
      setState(() {
        _quote = quote;
      });
    } catch (e) {
      print('Failed to fetch quote: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load quote. Please try again.')),
      );
    }
  }
//new
final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // Method to show coffee details when clicked
  void showCoffeeDetails(Coffee coffee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 177, 156, 128),
        title: Text(coffee.title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Description: ${coffee.description}'),
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
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: signUserOut,
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                // Display the quote at the top of the page
                if (_quote != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        Text(
                          _quote!.content,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '- ${_quote!.author}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                // Heading message
                const Text(
                  "How would you like your coffee?",
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'Playball',
                  ),
                ),
                const SizedBox(height: 25),

                // List of coffee to buy
                Expanded(
                  child: value.coffeeShop.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: value.coffeeShop.length,
                          itemBuilder: (context, index) {
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
      ),
    );
  }
}
