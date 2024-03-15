import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Todo bloc'),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
