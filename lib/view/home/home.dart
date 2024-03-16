import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/view/widget/bottom_sheet.dart';

TextEditingController titlecontroller = TextEditingController();
TextEditingController descriptioncontroller = TextEditingController();

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    context.read<TodoBloc>().add(Initialfetching());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 124, 152, 127),
        centerTitle: true,
        title: const Text('Todo bloc'),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is DataAdded) {
            Navigator.of(context).pop();
            titlecontroller.clear();
            descriptioncontroller.clear();
          }
          if (state is DataAddingError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.yellow,
            ));
          }
          if (state is DataDeleting) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Center(child: Text('Data deleted')),
              backgroundColor: Colors.red,
            ));
          }
          if (state is DataDeletingerror) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Center(child: Text(state.error))));
          }
          if (state is Dataeditingerror) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Center(child: Text(state.error))));
          }
          if (state is DataEditingfinished) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is Dataloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is Datafetched) {
            if (state.store.isEmpty) {
              return const Expanded(
                  child: Center(
                child: Text(
                  'Data is empty',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ));
            }
            return ListView.builder(
              itemCount: state.store.length,
              itemBuilder: (context, index) {
                final item = state.store[index];
                final id = item.id;
                return Padding(
                  padding: index == state.store.length - 1
                      ? const EdgeInsets.only(bottom: 80)
                      : const EdgeInsets.all(0),
                  child: Card(
                    color: const Color.fromARGB(255, 124, 152, 127),
                    margin: const EdgeInsets.all(10),
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        item.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        item.description,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showbottomsheet(context, id, index, state);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                context
                                    .read<TodoBloc>()
                                    .add(Deletedata(id: id));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text("error in fetching dataa"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showbottomsheet(context, null, null, null);
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
