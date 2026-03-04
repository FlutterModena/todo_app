import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/common/models/todo_model.dart';

part 'todo_provider.g.dart';

/// A list of todos, for this example.
/// In a real app, this would be fetched from a database or an API.
final todos = <TodoModel>[];

/// A provider that fetches the list of todos.
@riverpod
Future<List<TodoModel>> todoList(Ref ref) async {
  return Future.delayed(
    const Duration(seconds: 1),
    () => todos,
  );
}
