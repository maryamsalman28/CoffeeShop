import 'package:flutter/material.dart';
import 'package:fluttertest/models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  void Function()? onPressed;

  final Widget icon;

 CoffeeTile({
  super.key, 
  required this.coffee,
   required this.onPressed,
   required this.icon,
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
        border:Border.all(color: Colors.black, width: 1.0,),
        
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical:25, horizontal: 10),
      child: ListTile(
        title: Text(coffee.name),
        subtitle: Text(coffee.price),
        leading: Image.asset(coffee.imagePath),
        trailing: IconButton(
          icon: icon,
          onPressed: onPressed,
          ),
        
      ),
    );
  }
}