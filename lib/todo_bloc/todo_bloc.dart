import 'package:bloc/bloc.dart';
import 'package:todo_bloc/data/data_repositery.dart';
import 'package:todo_bloc/model/todo_model.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(Initialstate()) {
    on<Initialfetching>(initialfuntion);
    on<Adddata>(addingfuntion);
    on<Editdata>(editingfuntion);
    on<Deletedata>(deletingfun);
  }
  initialfuntion(Initialfetching event, Emitter<TodoState> emit) async {
    emit(Dataloading());
    try {
      final items = await Datarepositery().getdata();
      final List<Todomodel> notes = [];
      for (int i = 0; i < items.length; i++) {
        notes.add(Todomodel(
            title: items[i]['title'],
            description: items[i]['description'],
            id: items[i]["_id"]));
      }
      emit(Datafetched(store: notes));
    } catch (e) {
      emit(Fetchingerror());
    }
  }

  addingfuntion(Adddata event, Emitter<TodoState> emit) async {
    emit(DataAdded());
    emit(Dataloading());
    try {
      final result =
          await Datarepositery().datasubmiting(event.title, event.description);
      if (result == 'success') {
        add(Initialfetching());
      }
    } catch (e) {
      emit(DataAddingError(e.toString()));
      add(Initialfetching());
    }
  }

  editingfuntion(Editdata event, Emitter<TodoState> emit) async {
    emit(Dataloading());
    try {
      final response = await Datarepositery()
          .updateData(event.id, event.title, event.description);
      emit(DataEditingfinished());
      if (response == 'success') {
        add(Initialfetching());
      } else {
        emit(Dataeditingerror(error: 'data editing area error'));
        add(Initialfetching());
      }
    } catch (e) {
      emit(Dataeditingerror(error: 'data editing area error'));
    }
  }

  deletingfun(Deletedata event, Emitter<TodoState> emit) async {
    emit(Dataloading());
    try {
      final response = await Datarepositery().deletingdata(event.id);
      if (response == 'success') {
        emit(DataDeleting());
        add(Initialfetching());
      }
    } catch (e) {
      emit(DataDeletingerror(error: 'data deleting area erro'));
      add(Initialfetching());
    }
  }
}
