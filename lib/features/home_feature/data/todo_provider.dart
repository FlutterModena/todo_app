import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/common/models/todo_model.dart';

part 'todo_provider.g.dart';

/// A provider that fetches the list of todos.
@riverpod
Future<List<TodoModel>> todoList(Ref ref) async {
  return [
    TodoModel(
      id: 0,
      title: 'Title 1',
      description: 'Description 1',
      category: .work,
      isCompleted: false,
      createdAt: .now(),
      expireAt: .now().add(const Duration(days: 7)),
    ),
  ];
}
