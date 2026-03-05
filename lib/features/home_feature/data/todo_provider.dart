import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/common/models/todo_model.dart';

part 'todo_provider.g.dart';
part 'todo_provider.freezed.dart';

/// A wrapper for the list of todos,
/// used to trigger a rebuild when the list changes.
@freezed
abstract class TodoListWrapper with _$TodoListWrapper {
  /// Creates a [TodoListWrapper] instance.
  const factory TodoListWrapper({
    required List<TodoModel> todos,
  }) = _TodoListWrapper;
}

/// A provider that fetches the list of todos.
@riverpod
class TodoList extends _$TodoList {
  @override
  FutureOr<TodoListWrapper> build() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => const TodoListWrapper(todos: []),
    );
  }

  /// A method that adds a new todo to the list or updates an existing one.
  void upsertTodo(TodoModel todo) {
    final todos = [...state.requireValue.todos];
    final index = todos.indexWhere((item) => item.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      state = AsyncData(TodoListWrapper(todos: todos));
      return;
    }

    final lastTodo = todos.isNotEmpty ? todos.last : null;
    final newId = (lastTodo?.id ?? 0) + 1;
    final newTodo = todo.copyWith(id: newId);

    todos.add(newTodo);

    state = AsyncData(TodoListWrapper(todos: todos));
  }

  /// A method that deletes a todo from the list.
  void deleteTodo(int id) {
    final todos = [...state.requireValue.todos]
      ..removeWhere((todo) => todo.id == id);

    state = AsyncData(TodoListWrapper(todos: todos));
  }
}

/// A provider that fetches the list of todos filtered by category.
@riverpod
Future<TodoListWrapper> filteredTodoList(
  Ref ref, {
  TodoCategory? category,
}) async {
  final wrapper = await ref.watch(todoListProvider.future);
  if (category == null) {
    return TodoListWrapper(todos: wrapper.todos);
  }

  return TodoListWrapper(
    todos: wrapper.todos
        .where(
          (todo) => todo.category == category,
        )
        .toList(),
  );
}
