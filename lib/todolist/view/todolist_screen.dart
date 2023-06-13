import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/common/layout/default_layout.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "TodoList",
      child: StreamBuilder(
        builder: (context, snapshot) {
          return Text("s");
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed("/addscreen");
        },
      ),
    );
  }
}
