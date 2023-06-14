import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';
import 'package:todolist/todolist/common/riverpod/addtodo_provider.dart';
import 'package:todolist/todolist/firebase/firestore.dart';

class TodoDetailDialog extends ConsumerWidget {
  final TodoModel data;
  const TodoDetailDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _TodoTextController =
        TextEditingController(text: data.todo);
    DateTime _selectedDate = ref.watch(dateProvider);

    return AlertDialog(
      //모서리 둥글게
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(child: Text(data.todo)),
      content: Column(
        children: [
          Text(
              "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}"),
          ElevatedButton(
              onPressed: () {
                //날짜 입력 받기
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                ).then((selectedDate) {
                  //date Riverpod으로 변경
                  ref
                      .read(dateProvider.notifier)
                      .update((state) => selectedDate!);
                });
              },
              child: Text("날짜 변경")),
          //todo 변경
          TextField(
            controller: _TodoTextController,
            onChanged: (value) {
              print(_TodoTextController.text);
            },
          )
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              if (_TodoTextController.text == "") {
                return null;
              } else {
                //model로 보내기 위해서 todo만 change된 값으로 다시 만들어서 보냄
                final replacedata = TodoModel(
                    date: _selectedDate.toString(),
                    id: data.id,
                    reference: data.reference,
                    success: data.success,
                    todo: _TodoTextController.text);
                DataReplace(replacedata);
                Navigator.pop(context);
              }
            },
            child: Text("완료")),
        ElevatedButton(
            autofocus: _TodoTextController.text == "" ? false : true,
            onPressed: () {
              DataRemove(data);
              Navigator.pop(context);
            },
            child: Text("삭제"))
      ],
    );
  }
}
