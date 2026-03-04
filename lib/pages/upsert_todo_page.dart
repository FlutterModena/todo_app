import 'package:flutter/material.dart';
import 'package:test/models/todo_model.dart';

class UpsertTodoPage extends StatefulWidget {
  const UpsertTodoPage({
    super.key,
    this.todo,
  });

  final TodoModel? todo;

  @override
  State<UpsertTodoPage> createState() => _UpsertTodoPageState();
}

class _UpsertTodoPageState extends State<UpsertTodoPage> {
  bool get isEdit => widget.todo != null;

  @override
  Widget build(BuildContext context) {
    final pageTitle = isEdit ? "Modifica Todo" : "Aggiungi Todo";
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
    );
  }
}
