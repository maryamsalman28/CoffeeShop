import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color? color;
  final void Function()? onTap;
  const MyButton({super.key, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.brown),
          
        ),
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        child: const Center(child: Text("Click here to change theme!")),
      ),
    );
  }
}