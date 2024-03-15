part of 'todo_bloc.dart';

sealed class TodoState {}

class Initialstate extends TodoState {}

class Dataloading extends TodoState {}

class Datafetched extends TodoState {
  final List<Todomodel> store;
  Datafetched({required this.store});
}

class Fetchingerror extends TodoState {}

final class DataAdded extends TodoState {}

final class DataAddingError extends TodoState {
  final String error;

  DataAddingError(this.error);
}
