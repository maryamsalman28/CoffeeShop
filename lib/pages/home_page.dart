import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertest/components/bottom_nav_bar.dart';
import 'package:fluttertest/const.dart';
import 'package:fluttertest/pages/information_page.dart';
import 'package:fluttertest/models/coffee_shop.dart';
import 'package:fluttertest/pages/cart_page.dart';
import 'package:fluttertest/pages/contact_us_page.dart';
import 'package:fluttertest/pages/shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

//sign user out
  
  //sign user out

  @override



  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //navigate bottom bar
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages
  final List<Widget> _pages = [
    //shop page
    ShopPage(),

    //cart page
    CartPage(),

    //about us page
    InformationPage(),

    //contact us page
    ContactUsPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CoffeeShop>(context, listen: false).fetchAndLoadCoffees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
