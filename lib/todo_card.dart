import 'package:flutter/material.dart';
import 'package:test/extensions.dart';
import 'package:test/todo_model.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.todo,
  });

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
        padding: .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              todo.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 8),
            Text(todo.description),
          ],
        ),
      ),
    );
  }
}
