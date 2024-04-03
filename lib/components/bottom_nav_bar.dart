import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
   MyBottomNavBar ({super.key, required this.onTabChange,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(143, 230, 216, 207),
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.all(10),
  
      child: GNav(
        onTabChange: (value) => onTabChange! (value) ,
      color: Color.fromARGB(255, 90, 90, 90),
      mainAxisAlignment: MainAxisAlignment.center,
      activeColor: Colors.grey[700],
      tabBackgroundColor: Colors.grey.shade300,
      tabBorderRadius: 24,
      tabActiveBorder:Border.all(color: Colors.white),
      tabs: const [
      GButton(icon: Icons.shopping_bag,
      text: 'Shop',
      padding: EdgeInsets.all(20),
      ),
      GButton(icon: Icons.shopping_cart,
      text: 'Cart',
      padding: EdgeInsets.all(20),
      ),
      GButton(icon: Icons.info,
      text: 'About Us',
      padding: EdgeInsets.all(20),
      ),
      GButton(icon: Icons.phone,
      text: 'Contact Us',
      padding: EdgeInsets.all(20),
      ),
    ],
      ),
    );
  }
}
