import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_todo_list/bloc/todo_bloc.dart';

class StatTodoPage extends StatelessWidget {
  const StatTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String markAllCompleted = 'MarkAllCompleted';
    String deleteAllCompleted = 'DeleteAllCompleted';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter todos'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoLoaded) {
                final listTodo = context.select((TodoBloc bloc){
                  var state = bloc.state;
                  var todoCompleted = 0;
                  var todoNoCompleted = 0;
                  if (state is TodoLoaded) {
                    todoCompleted = state.todos.where((element) => element.isCompleted == true).length;
                    todoNoCompleted = state.todos.where((element) => element.isCompleted == false).length;
                  }
                  return {"completed": todoCompleted, "inCompleted": todoNoCompleted};
                });
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Todo non fini :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(listTodo['inCompleted'].toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Todo fini :',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(listTodo['completed'].toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
