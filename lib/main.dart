import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_list/bloc/todo_bloc.dart';
import 'package:hive_todo_list/screens/home_todo.dart';

import 'models/todo_model.dart';

Future<void> main() async {
  // init the hive
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  await Hive.openBox('todoBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => TodoBloc()..add(TodoLoadedEvent()),
        child: const HomePage(),
      ),
    );
  }
}
