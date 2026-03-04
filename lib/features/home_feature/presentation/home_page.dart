import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/extensions.dart';
import 'package:todo_app/features/home_feature/presentation/dynamic_todo_list.dart';
import 'package:todo_app/features/home_feature/presentation/todo_filters.dart';
import 'package:todo_app/features/upsert_feature/presentation/upsert_todo_page.dart';

/// The home page of the app, where the list of todos is displayed.
class HomePage extends ConsumerStatefulWidget {
  /// Creates a [HomePage] widget.
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _index = 0;

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
          unawaited(
            const UpsertTodoPage().push(context),
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
            const SliverPadding(
              padding: .symmetric(vertical: 16),
              sliver: DynamicTodoList(),
            ),
          ],
        ),
      ),
    );
  }
}
