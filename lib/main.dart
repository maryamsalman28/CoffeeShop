import 'package:flutter/material.dart';
import 'package:fluttertest/models/coffee_shop.dart';
import 'package:fluttertest/pages/login_page.dart';
import 'package:fluttertest/themes/dark_theme.dart';
import 'package:fluttertest/themes/light_theme.dart';
import 'package:fluttertest/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child:const MyApp(),
    ),
  );
  

    
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoffeeShop(),
      builder: (context, child) =>  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themedata,
        home: const LoginPage(),

        
      
      ),
      );
    
  }
}