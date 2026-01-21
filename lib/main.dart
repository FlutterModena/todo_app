import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  void _changeFilter(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SizedBox(
        height: 32,
        child: ListView(
          scrollDirection: .horizontal,
          children: [
            SizedBox(width: 16),
            GestureDetector(
              onTap: () => _changeFilter(0),
              child: ChipTodo(title: "Tutti", isActive: _index == 0),
            ),
            SizedBox(width: 16),
            GestureDetector(
              onTap: () => _changeFilter(1),
              child: ChipTodo(title: "Lavoro", isActive: _index == 1),
            ),
            SizedBox(width: 16),
            GestureDetector(
              onTap: () => _changeFilter(2),
              child: ChipTodo(title: "Personale", isActive: _index == 2),
            ),
          ],
        ),
      ),
    );
  }
}

class ChipTodo extends StatelessWidget {
  const ChipTodo({super.key, required this.title, required this.isActive});

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive ? Colors.blueAccent : Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Text(title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
