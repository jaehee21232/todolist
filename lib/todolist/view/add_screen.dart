import 'package:flutter/material.dart';
import 'package:todolist/common/layout/appbar.dart';
import 'package:todolist/todolist/common/component/add_button.dart';
import 'package:todolist/todolist/common/component/date.dart';
import 'package:todolist/common/layout/default_layout.dart';
import 'package:todolist/todolist/common/component/reference.dart';
import 'package:todolist/todolist/common/component/todo.dart';

class TodoAddScreen extends StatelessWidget {
  const TodoAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: renderAppBar("추가하기"),
      child: Center(
        child: Column(
          children: [
            AddDate(),
            SizedBox(
              height: 16,
            ),
            AddTodo(),
            SizedBox(
              height: 16,
            ),
            AddReference(),
            SizedBox(
              height: 16,
            ),
            AddButton(),
          ],
        ),
      ),
    );
  }
}
