import 'package:flutter/material.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';
import 'package:todolist/todolist/firebase/firestore.dart';

class TodoDetailDialog extends StatelessWidget {
  final TodoModel data;
  const TodoDetailDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //모서리 둥글게
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(child: Text(data.todo)),
      content: Column(
        children: [],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(onPressed: () {}, child: Text("완료")),
        ElevatedButton(
            onPressed: () {
              DataRemove(data);
              Navigator.pop(context);
            },
            child: Text("삭제"))
      ],
    );
  }
}
