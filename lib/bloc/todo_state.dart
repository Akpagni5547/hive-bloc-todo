part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded({required this.todos});

  TodoLoaded copyWith({
    List<Todo>? todos,
  }) {
    return TodoLoaded(todos: todos ?? this.todos);
  }

  @override
  List<Object> get props => [todos];
}
