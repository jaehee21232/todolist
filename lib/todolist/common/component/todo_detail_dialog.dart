import 'package:flutter/material.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';
import 'package:todolist/todolist/firebase/firestore.dart';

class TodoDetailDialog extends StatelessWidget {
  final TodoModel data;
  const TodoDetailDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    TextEditingController TodoTextController =
        TextEditingController(text: data.todo);
    return AlertDialog(
      //모서리 둥글게
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(child: Text(data.todo)),
      content: Column(
        children: [
          //todo 변경
          TextField(
            controller: TodoTextController,
            onChanged: (value) {
              print(TodoTextController.text);
            },
          )
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              if (TodoTextController.text == "") {
                return null;
              } else {
                //model로 보내기 위해서 todo만 change된 값으로 다시 만들어서 보냄
                final replacedata = TodoModel(
                    date: data.date,
                    id: data.id,
                    reference: data.reference,
                    success: data.success,
                    todo: TodoTextController.text);
                DataReplace(replacedata);
                Navigator.pop(context);
              }
            },
            child: Text("완료")),
        ElevatedButton(
            autofocus: TodoTextController.text == "" ? false : true,
            onPressed: () {
              DataRemove(data);
              Navigator.pop(context);
            },
            child: Text("삭제"))
      ],
    );
  }
}
