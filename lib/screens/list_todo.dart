import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_todo_list/bloc/todo_bloc.dart';
import 'package:hive_todo_list/screens/add_todo.dart';
import 'package:hive_todo_list/screens/detail_todo.dart';

class ListTodoPage extends StatelessWidget {
  const ListTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter todos'),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<TodoBloc>(context),
                        child: const AddTodoPage(),
                      )));
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                // print('state screeee ${state}');
                if (state is TodoLoaded) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: ValueKey<String>(state.todos[index].id),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.redAccent,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {
                        context
                            .read<TodoBloc>()
                            .add(TodoDeleteEvent(id: state.todos[index].id));
                      },
                      child: ListTile(
                        title: Text(state.todos[index].title,
                            style: TextStyle(
                                decoration: state.todos[index].isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                      value: todoBloc,
                                      child: DetailTodoPage(
                                        todo: state.todos[index],
                                      ))));
                        },
                        leading: Checkbox(
                          value: state.todos[index].isCompleted,
                          onChanged: (bool? value) {
                            context
                                .read<TodoBloc>()
                                .add(TodoCheckedEvent(id: state.todos[index].id));
                          },
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.vertical,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
}
