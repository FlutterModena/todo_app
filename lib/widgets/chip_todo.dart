import 'package:flutter/material.dart';

class ChipTodo extends StatelessWidget {
  const ChipTodo({super.key, required this.title, required this.isActive});

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive ? Colors.blueAccent : Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Text(title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}