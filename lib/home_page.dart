import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test/extensions.dart';
import 'package:test/todo_card.dart';
import 'package:test/todo_filters.dart';
import 'package:test/todo_model.dart';
import 'package:test/upsert_todo_page.dart';

/// The home page of the app, where the list of todos is displayed.
class HomePage extends StatefulWidget {
  /// Creates a [HomePage] widget.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  late final todos = [
    TodoModel(
      id: 0,
      title: 'Title 1',
      description: 'Description 1',
      category: TodoCategory.work,
      isCompleted: false,
      createdAt: .now(),
      expireAt: .now().add(const Duration(days: 7)),
    ),
  ];

  void _changeFilter(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leadingWidth: 64,
        leading: const Column(
          mainAxisAlignment: .center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://gravatar.com/avatar/9b1c8e5a0c7f2d9e4b8a1c6e5f3a2b?s=200&d=robohash&r=x',
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO(dariowskii): create a shorcut in extensions for this
          // TODO(dariowskii): save the new todo in the list
          unawaited(
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const UpsertTodoPage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const .symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const .only(top: 16, bottom: 4),
                child: Text(
                  'Ciao! Ecco i tuoi task',
                  style: context.textTheme.headlineLarge?.copyWith(
                    fontWeight: .bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const .only(bottom: 24),
                child: Text(DateTime.now().format('EEEE, dd MMMM')),
              ),
            ),
            SliverToBoxAdapter(
              child: TodoFilters(
                currentIndex: _index,
                onChange: _changeFilter,
              ),
            ),
            SliverPadding(
              padding: const .symmetric(vertical: 16),
              sliver: SliverList.separated(
                itemCount: todos.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (_, index) => TodoCard(todo: todos[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
