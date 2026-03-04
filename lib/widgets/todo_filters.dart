import 'package:flutter/material.dart';
import 'package:test/widgets/chip_todo.dart';

class TodoFilters extends StatelessWidget {
  const TodoFilters({
    super.key,
    required this.currentIndex,
    required this.onChange,
  });

  final int currentIndex;
  final Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView(
        scrollDirection: .horizontal,
        children: [
          SizedBox(width: 16),
          GestureDetector(
            onTap: () => onChange(0),
            child: ChipTodo(title: "Tutti", isActive: currentIndex == 0),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () => onChange(1),
            child: ChipTodo(title: "Lavoro", isActive: currentIndex == 1),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () => onChange(2),
            child: ChipTodo(title: "Personale", isActive: currentIndex == 2),
          ),
        ],
      ),
    );
  }
}
