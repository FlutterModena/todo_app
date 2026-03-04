
import 'package:flutter/material.dart';
import 'package:test/extensions.dart';
import 'package:test/models/todo_model.dart';
import 'package:test/widgets/todo_card.dart';
import 'package:test/widgets/todo_filters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  void _changeFilter(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final todos = [
      TodoModel(
        id: '1',
        title: 'Title 1',
        description: 'Description 1',
        category: 'Category 1',
        isCompleted: false,
        createdAt: .now(),
        expireAt: .now().add(Duration(days: 7)),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          mainAxisAlignment: .center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://gravatar.com/avatar/9b1c8e5a0c7f2d9e4b8a1c6e5f3a2b?s=200&d=robohash&r=x",
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Padding(
        padding: .symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: .only(top: 16, bottom: 4),
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
                padding: .only(bottom: 24),
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
              padding: .symmetric(vertical: 16),
              sliver: SliverList.separated(
                itemCount: todos.length,
                separatorBuilder: (_, _) => SizedBox(height: 16),
                itemBuilder: (_, index) => TodoCard(todo: todos[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}