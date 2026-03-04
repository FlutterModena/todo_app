import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test/common/models/todo_model.dart';

part 'todo_provider.g.dart';

@riverpod
Future<List<TodoModel>> todoList(Ref ref) {
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
  ]
}