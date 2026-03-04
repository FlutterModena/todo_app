import 'package:flutter/material.dart';
import 'package:test/chip_todo.dart';
import 'package:test/todo_model.dart';

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
    final filters = [
      "Tutti",
      ...TodoCategory.values.map((e) => e.label),
    ];

    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: .horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onChange(index),
            child: ChipTodo(
              title: filters[index],
              isActive: currentIndex == index,
            ),
          );
        },
      ),
    );
  }
}
