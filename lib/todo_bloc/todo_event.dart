part of 'todo_bloc.dart';

sealed class TodoEvent {}

class Initialfetching extends TodoEvent {}

class Adddata extends TodoEvent {
  final String title;
  final String description;

  Adddata({required this.title, required this.description});
}

class Editdata extends TodoEvent {
  final String id;
  final String title;
  final String description;

  Editdata({required this.id, required this.title, required this.description});
}

class Deletedata extends TodoEvent {
  final String id;

  Deletedata({required this.id});
}
