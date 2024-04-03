import 'package:flutter/material.dart';
import 'package:fluttertest/components/button.dart';
import 'package:fluttertest/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                    },
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(129, 238, 238, 238),
                      border: Border.all(
                        color: Colors.brown,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Coffee Cove!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Playball',
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'At Coffee Cove, we are passionate about serving high-quality coffee in a cozy and welcoming atmosphere. Our commitment to excellence extends beyond our coffee beans; we prioritize customer satisfaction and strive to create a memorable experience with every cup.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Our Values:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Playball',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '- Quality: We source the finest coffee beans and ingredients to ensure the best possible taste in every cup.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '- Community: Coffee Cove is more than just a café; it\'s a place where friends gather, ideas flow, and connections are made.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '- Sustainability: We are committed to environmentally-friendly practices, from sourcing ethically-produced beans to reducing waste in our operations.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Visit us today and experience the warmth and flavor of Coffee Cove!',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
