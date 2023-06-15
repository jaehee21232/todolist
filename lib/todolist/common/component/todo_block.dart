import 'package:flutter/material.dart';
import 'package:todolist/todolist/common/component/todo_detail_dialog.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';

class TodoBlock extends StatelessWidget {
  final TodoModel data;
  const TodoBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //탭 하면 dialog 페이지로
        showDialog(
          context: context,
          builder: (context) => TodoDetailDialog(data: data),
        );
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: data.success ? Colors.blue[200] : Colors.white,
            border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
        child: Center(
          child: Row(
            children: [
              Icon(data.success == false
                  ? Icons.check_circle_outline
                  : Icons.check_circle),
              const SizedBox(
                width: 12,
              ),
              Text(
                data.todo,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
