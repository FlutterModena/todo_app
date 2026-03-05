import 'package:flutter/material.dart';
import 'package:todo_app/common/models/todo_model.dart';
import 'package:todo_app/features/home_feature/presentation/chip_todo.dart';

/// A widget that displays a list of filters for the todos.
class TodoFilters extends StatelessWidget {
  /// Creates a [TodoFilters] widget.
  const TodoFilters({
    required this.onChange,
    this.filter,
    super.key,
  });

  /// The currently selected filter, or null if no filter is selected.
  final TodoCategory? filter;

  /// A callback that is called when the user selects a filter.
  final void Function(TodoCategory? category) onChange;

  bool _isActive(int index) {
    if (index == 0) {
      return filter == null;
    }

    return filter == TodoCategory.values[index - 1];
  }

  void _sendOnChange(int index) {
    if (index == 0) {
      return onChange(null);
    }

    onChange(TodoCategory.values[index - 1]);
  }

  @override
  Widget build(BuildContext context) {
    final labels = [
      'Tutti',
      ...TodoCategory.values.map((e) => e.label),
    ];

    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: .horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: labels.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _sendOnChange(index),
            child: ChipTodo(
              title: labels[index],
              isActive: _isActive(index),
            ),
          );
        },
      ),
    );
  }
}
