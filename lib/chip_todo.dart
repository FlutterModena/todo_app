import 'package:flutter/material.dart';
import 'package:test/extensions.dart';

class ChipTodo extends StatelessWidget {
  const ChipTodo({super.key, required this.title, required this.isActive});

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive
        ? context.colorScheme.primaryContainer
        : context.colorScheme.surfaceContainer;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: .circular(20),
      ),
      child: Padding(
        padding: .symmetric(horizontal: 16),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
