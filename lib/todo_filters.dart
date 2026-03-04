import 'package:flutter/material.dart';
import 'package:test/chip_todo.dart';
import 'package:test/todo_model.dart';

/// A widget that displays a list of filters for the todos.
class TodoFilters extends StatelessWidget {
  /// Creates a [TodoFilters] widget.
  const TodoFilters({
    required this.currentIndex,
    required this.onChange,
    super.key,
  });

  /// The index of the currently selected filter.
  final int currentIndex;

  /// A callback that is called when the user selects a filter.
  final void Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    final filters = [
      'Tutti',
      ...TodoCategory.values.map((e) => e.label),
    ];

    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: .horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
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
