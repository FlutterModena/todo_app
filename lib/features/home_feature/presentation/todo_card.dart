import 'package:flutter/material.dart';
import 'package:test/extensions.dart';
import 'package:test/common/models/todo_model.dart';

/// A widget that represents a single todo item in the list.
class TodoCard extends StatelessWidget {
  /// Creates a [TodoCard] widget.
  const TodoCard({
    required this.todo,
    super.key,
  });

  /// The todo model to display.
  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    // TODO(dariowskii): Complete following the UI design
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: .circular(16),
      ),
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(todo.description),
          ],
        ),
      ),
    );
  }
}
