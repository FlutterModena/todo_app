import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home_feature/data/todo_provider.dart';
import 'package:todo_app/features/home_feature/presentation/todo_card.dart';
import 'package:todo_app/features/upsert_feature/presentation/upsert_todo_page.dart';

/// A widget that displays a list of todos, which is fetched from the provider.
class DynamicTodoList extends ConsumerWidget {
  /// Creates a [DynamicTodoList] widget.
  const DynamicTodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);

    return switch (todoList) {
      AsyncData(value: final todos) => SliverList.separated(
        itemCount: todos.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              unawaited(
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => UpsertTodoPage(
                      todo: todos[index],
                    ),
                  ),
                ),
              );
            },
            child: TodoCard(todo: todos[index]),
          );
        },
      ),
      AsyncError(:final error) => SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text('Errore: $error'),
        ),
      ),
      _ => const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    };
  }
}
