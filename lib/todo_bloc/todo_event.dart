part of 'todo_bloc.dart';

sealed class TodoEvent {}

class Adddata extends TodoEvent {
  final String title;
  final String description;

  Adddata({required this.title, required this.description});
}

class Editdata extends TodoEvent {}

class Deletedata extends TodoEvent {}

class Initialfetching extends TodoEvent {}
