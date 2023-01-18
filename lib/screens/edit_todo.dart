import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_todo_list/bloc/todo_bloc.dart';
import '../models/todo_model.dart';

class EditTodoPage extends StatelessWidget {
  final Todo todo;
  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleTodo = TextEditingController(text: todo.title);
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Edit todo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: titleTodo,
                maxLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.grey, width: 2.0)),
                    hintText: 'Ajouter la description'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(TodoUpdateEvent(
                            todo: Todo(
                                title: titleTodo.text,
                                isCompleted: todo.isCompleted,
                                id: todo.id)));
                        Navigator.pop(context);
                      },
                      child: const Text('Modifier'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
