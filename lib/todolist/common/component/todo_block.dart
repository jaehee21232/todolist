import 'package:flutter/material.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';

class TodoBlock extends StatelessWidget {
  final TodoModel data;
  const TodoBlock({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
        child: Center(
          child: Row(
            children: [
              Icon(data.success == false
                  ? Icons.check_circle_outline
                  : Icons.check_circle),
              SizedBox(
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
