import 'package:flutter/material.dart';
import 'package:fluttertest/pages/auth_page.dart';
import 'package:fluttertest/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'models/coffee_shop.dart';
import 'pages/login_page.dart';
import 'themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
 );
  


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CoffeeShop()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themedata,
      home:  AuthPage(),
    );
  }
}
