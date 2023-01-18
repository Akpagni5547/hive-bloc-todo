import 'package:flutter/material.dart';
import 'package:hive_todo_list/screens/list_todo.dart';
import 'package:hive_todo_list/screens/stat_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  static List<Widget> pages = const [
    ListTodoPage(),
    StatTodoPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Todos'),
          BottomNavigationBarItem(icon: Icon(Icons.query_stats), label: 'Stats')
        ],
        onTap: (int indexSelected){
          setState(() {
            currentIndex = indexSelected;
          });
        },
      ),
      body: pages[currentIndex],
    );
  }
}
