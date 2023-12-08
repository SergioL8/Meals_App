import 'package:flutter/material.dart';

/*
* This class just creates a row with an icon and a label
*/
class MealItemTrait extends StatelessWidget {

  const MealItemTrait({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 2,),
        Text(
          label,
          style: const TextStyle(color: Colors.white),)
      ],
    );
  }
}