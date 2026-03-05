import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/common/models/todo_model.dart';
import 'package:todo_app/extensions.dart';
import 'package:todo_app/features/home_feature/data/todo_provider.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: .circular(8),
        border: Border.all(
          color: context.colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const .all(16),
        child: Row(
          crossAxisAlignment: .start,
          spacing: 12,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final isCompleted = todo.isCompleted;
                return GestureDetector(
                  onTap: () {
                    final newTodo = todo.copyWith(
                      isCompleted: !todo.isCompleted,
                    );
                    ref.read(todoListProvider.notifier).upsertTodo(newTodo);
                  },
                  child: Icon(
                    isCompleted ? Icons.check_circle : Icons.circle_outlined,
                    color: context.colorScheme.primary,
                  ),
                );
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 8,
                children: [
                  Text(
                    todo.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: .bold,
                    ),
                  ),
                  Text(todo.description),
                ],
              ),
            ),
            Icon(
              Icons.more_vert,
              color: context.colorScheme.outlineVariant,
            ),
          ],
        ),
      ),
    );
  }
}
