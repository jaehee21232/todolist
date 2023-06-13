import 'package:flutter/material.dart';
import 'package:todolist/todolist/common/component/date.dart';
import 'package:todolist/common/layout/default_layout.dart';
import 'package:todolist/todolist/common/component/reference.dart';
import 'package:todolist/todolist/common/component/todo.dart';

class TodoAddScreen extends StatelessWidget {
  const TodoAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Column(
          children: [const AddDate(), const AddTodo(), AddReference()],
        ),
      ),
      title: "추가하기",
    );
  }
}
