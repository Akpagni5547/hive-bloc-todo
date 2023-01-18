import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_list/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final _todoBox = Hive.box('todoBox');
  TodoBloc() : super(TodoInitial()) {
    on<TodoLoadedEvent>((event, emit) {
      List<dynamic> todos = _todoBox.get('TODOLIST', defaultValue: []);
      List<Todo> todoLoaded = todos.cast<Todo>();
      emit(TodoLoaded(todos: todoLoaded));
    });

    on<TodoAddEvent>((event, emit) {
      final state = this.state as TodoLoaded;
      var todos = [...state.todos, event.todo];
      emit(state.copyWith(todos: todos));
      _todoBox.put('TODOLIST', todos);
    });

    on<TodoUpdateEvent>((event, emit){
      final state = this.state as TodoLoaded;
      List<Todo> todos = state.todos.map((e) => Todo(id: e.id, title: e.title, isCompleted: e.isCompleted)).toList();
      var indexTodo = todos.indexWhere((element) => element.id == event.todo.id);
      todos[indexTodo] = event.todo;
      emit(state.copyWith(todos: todos));
      _todoBox.put('TODOLIST', todos);
    });

    on<TodoCheckedEvent>((event, emit){
      final state = this.state as TodoLoaded;
      List<Todo> todos = state.todos.map((e) => Todo(id: e.id, title: e.title, isCompleted: e.isCompleted)).toList();
      var indexTodo = state.todos.indexWhere((element) => element.id == event.id);
      todos[indexTodo].isCompleted = !state.todos[indexTodo].isCompleted;
      emit(state.copyWith(todos: todos));
      _todoBox.put('TODOLIST', todos);
    });

    on<TodoDeleteEvent>((event, emit){
      final state = this.state as TodoLoaded;
      List<Todo> todos = state.todos.map((e) => Todo(id: e.id, title: e.title, isCompleted: e.isCompleted)).toList();
      todos.removeWhere((element) => element.id == event.id);
      emit(state.copyWith(todos: todos));
      _todoBox.put('TODOLIST', todos);
    });
  }
}
