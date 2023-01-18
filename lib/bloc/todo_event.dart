part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class TodoLoadedEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class TodoAddEvent extends TodoEvent {
  final Todo todo;
  const TodoAddEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class TodoCheckedEvent extends TodoEvent {
  final String id;
  const TodoCheckedEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class TodoUpdateEvent extends TodoEvent {
  final Todo todo;
  const TodoUpdateEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class TodoDeleteEvent extends TodoEvent {
  final String id;
  const TodoDeleteEvent({required this.id});

  @override
  List<Object?> get props => [id];
}