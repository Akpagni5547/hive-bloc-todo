import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_todo_list/bloc/todo_bloc.dart';
import 'package:hive_todo_list/screens/edit_todo.dart';

import '../models/todo_model.dart';

class DetailTodoPage extends StatelessWidget {
  final Todo todo;

  const DetailTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);
    // final Todo todo = context.select((TodoBloc bloc) => bloc.state.where((element) => element.id == id).first);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail todo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                context.read<TodoBloc>().add(TodoDeleteEvent(id: todo.id));
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                      value: todoBloc,
                      child: EditTodoPage(
                        todo: todo,
                      ))));
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: Text(todo.title,
                    style: TextStyle(
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
