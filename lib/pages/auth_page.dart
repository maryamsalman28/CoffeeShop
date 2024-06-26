import 'package:flutter/material.dart';
import 'package:fluttertest/pages/login_or_register_page.dart';
import 'package:fluttertest/pages/login_page.dart';
import 'package:fluttertest/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return HomePage();
          } else {
            return LoginOrRegisterPage();
          }
        }
      )
    );
  }
}