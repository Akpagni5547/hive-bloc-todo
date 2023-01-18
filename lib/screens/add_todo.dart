import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_todo_list/bloc/todo_bloc.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleTodo = TextEditingController();
    TextEditingController descriptionTodo = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add todo'),
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
                    hintText: 'Ajouter le titre'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        var uuid = const Uuid();
                        context.read<TodoBloc>().add(TodoAddEvent(
                            todo: Todo(
                                title: titleTodo.text,
                                isCompleted: false,
                                id: uuid.v4())));
                        Navigator.pop(context);
                      },
                      child: const Text('Ajouter'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
