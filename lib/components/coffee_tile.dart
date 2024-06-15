import 'package:flutter/material.dart';
import 'package:fluttertest/models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  final Icon icon;
  final VoidCallback onPressed;

  CoffeeTile({
    required this.coffee,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(coffee.image, width: 50, height: 50),
      title: Text(coffee.title),
      subtitle: Text(coffee.description),
      trailing: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
