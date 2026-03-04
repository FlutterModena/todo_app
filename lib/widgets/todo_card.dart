import 'package:flutter/material.dart';
import 'package:test/models/todo_model.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.todo,
  });

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
