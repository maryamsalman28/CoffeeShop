import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/components/my_button.dart';
import 'package:fluttertest/components/my_textfield.dart';
import 'package:fluttertest/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
//show loading circle
showDialog(
  context: context,
  builder: (context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  },
);


try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    Navigator.pop(context);

} on FirebaseAuthException catch (e) {
      Navigator.pop(context);

  showErrorMessage(e.code);
} 

  }

  // wrong email message popup
void showErrorMessage(String message) {
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text( 
            message,
            style: TextStyle(color: Colors.red)
          )
        )
      );
    },
  );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.coffee,
                size: 70,
              ),

              const SizedBox(height: 30),

              // welcome back, you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 15),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 6),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 6),

              // forgot password?
              

              const SizedBox(height: 15),

              // sign in button
              MyButton(
                text: 'Sign In',
                onTap: signUserIn,
              ),

              const SizedBox(height: 30),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    //Padding(
                      //padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      //child: Text(
                        //'Or continue with',
                        //style: TextStyle(color: Colors.grey[700]),
                      //),
                   // ),
                    //Expanded(
                    //  child: Divider(
                      //  thickness: 0.5,
                      // color: Colors.grey[400],
                     // ),
                    //),
                  ],
                ),
              ),

              //const SizedBox(height: 30),

              // google + apple sign in buttons
             // Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
               // children: const [
                  // google button
                  //SquareTile(imagePath: 'lib/images/google.png'),

                  //SizedBox(width: 25),

                  // apple button
                  //SquareTile(imagePath: 'lib/images/apple.png')
                ///],
              //),

              const SizedBox(height: 30),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}