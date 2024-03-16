import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/view/home/home.dart';

void showbottomsheet(
    BuildContext context, String? id, int? index, Datafetched? state) {
  if (id != null) {
    titlecontroller.text = state!.store[index!].title;
    descriptioncontroller.text = state.store[index].description;
  } else {
    if (id == null) {
      titlecontroller.clear();
      descriptioncontroller.clear();
    }
  }
  showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                  top: 15,
                  left: 15,
                  right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: titlecontroller,
                    decoration: const InputDecoration(hintText: "title"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: descriptioncontroller,
                    decoration: const InputDecoration(hintText: "description"),
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          id == null
                              ? context.read<TodoBloc>().add(Adddata(
                                  title: titlecontroller.text,
                                  description: descriptioncontroller.text))
                              : context.read<TodoBloc>().add(Editdata(
                                  id: id,
                                  title: titlecontroller.text,
                                  description: descriptioncontroller.text));
                        },
                        child: Text(id == null ? "Add" : "Update")),
                  )
                ],
              ),
            ),
          ));
}
