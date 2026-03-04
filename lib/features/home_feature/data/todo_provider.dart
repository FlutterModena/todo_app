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

/// A provider that fetches the list of todos filtered by category.
@riverpod
Future<List<TodoModel>> filteredTodoList(
  Ref ref, {
  TodoCategory? category,
}) async {
  final todos = await ref.watch(todoListProvider.future);
  if (category == null) {
    return todos;
  }

  return todos.where((todo) => todo.category == category).toList();
}

/// A provider that adds a new todo to the list.
@riverpod
void addTodo(Ref ref, TodoModel todo) {
  final lastTodo = todos.isNotEmpty ? todos.last : null;
  final newId = (lastTodo?.id ?? 0) + 1;
  final newTodo = todo.copyWith(id: newId);

  todos.add(newTodo);
}

/// A provider that updates an existing todo in the list.
@riverpod
void updateTodo(Ref ref, TodoModel updatedTodo) {
  final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
  if (index != -1) {
    todos[index] = updatedTodo;
  }
}

/// A provider that deletes a todo from the list.
@riverpod
void deleteTodo(Ref ref, int id) {
  todos.removeWhere((todo) => todo.id == id);
}
