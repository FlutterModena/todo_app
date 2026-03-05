import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/common/models/todo_model.dart';
import 'package:todo_app/extensions.dart';
import 'package:todo_app/features/home_feature/data/todo_provider.dart';
import 'package:todo_app/features/home_feature/presentation/todo_card.dart';
import 'package:todo_app/features/upsert_feature/presentation/upsert_todo_page.dart';

/// A widget that displays a list of todos, which is fetched from the provider.
class DynamicTodoList extends ConsumerWidget {
  /// Creates a [DynamicTodoList] widget.
  const DynamicTodoList({
    super.key,
    this.filter,
  });

  /// The filter for the list of todos, or null if no filter is applied.
  final TodoCategory? filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(
      filteredTodoListProvider(category: filter),
    );

    return switch (todoList) {
      AsyncData(value: final todos) => _ListHandler(todos: todos),
      AsyncError(:final error) => SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text('Errore: $error'),
        ),
      ),
      AsyncLoading() => const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    };
  }
}

class _ListHandler extends StatelessWidget {
  const _ListHandler({
    required this.todos,
  });

  final List<TodoModel> todos;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text('Nessun ToDo trovato.'),
        ),
      );
    }

    return SliverList.separated(
      itemCount: todos.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            unawaited(
              UpsertTodoPage(todo: todos[index]).push(context),
            );
          },
          child: TodoCard(todo: todos[index]),
        );
      },
    );
  }
}
