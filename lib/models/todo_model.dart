import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class Todo extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  late bool isCompleted;
  Todo({required this.id, required this.title, required this.isCompleted});

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, isCompleted];
}