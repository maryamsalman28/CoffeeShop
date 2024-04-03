import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), // Set app bar height to zero
        child: AppBar(
          backgroundColor: Colors.transparent, // Make app bar transparent
          elevation: 0, // Remove elevation
          automaticallyImplyLeading: false, // Remove the leading widget (back button)
          centerTitle: true, // Center align title
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'lib/images/background-coffee.jpg', // Replace with your background image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Content
          Center(
            child: Container(
              width: 400, // Adjust the width as needed
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[300]?.withOpacity(0.7), // Semi-transparent grey background
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "lib/images/coffee-beans.png", // Correct file path
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                    fit: BoxFit.contain, // Fit the image inside the container
                  ),
                  SizedBox(height: 20),
                    // "Register Now!" text
                    Text(
                    'Register Now!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Playball',
                    ),
                    textAlign: TextAlign.center,
                  ),
                    SizedBox(height: 20), // Adjust spacing as needed
                    // Registration Form Fields
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Implement registration logic here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      ),
                      child: Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    
  }
}
