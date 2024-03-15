import 'package:bloc/bloc.dart';
import 'package:todo_bloc/data/data_repositery.dart';
import 'package:todo_bloc/model/todo_model.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(TodoState initialState) : super(Initialstate()) {
    on<Initialfetching>(initialfuntion);
    on<Adddata>(addingfuntion);
  }
  initialfuntion(Initialfetching event, Emitter<TodoState> emit) {
    emit(Dataloading());
    try {
      final items = Datarepositery().getdata();
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
}
