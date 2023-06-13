import 'package:flutter/material.dart';
import 'package:todolist/todolist/common/component/add_button.dart';
import 'package:todolist/todolist/common/component/date.dart';
import 'package:todolist/common/layout/default_layout.dart';
import 'package:todolist/todolist/common/component/reference.dart';
import 'package:todolist/todolist/common/component/todo.dart';

class TodoAddScreen extends StatelessWidget {
  const TodoAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: "추가하기",
      child: Center(
        child: Column(
          children: [
            AddDate(),
            AddTodo(),
            AddReference(),
            AddButton(),
          ],
        ),
      ),
    );
  }
}
