import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/todolist/common/const/ref_snackbar.dart';
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
            decoration: InputDecoration(hintText: "TODO를 적어주세요!"),
            controller: _TodoTextController,
            onChanged: (value) {
              print(_TodoTextController.text);
            },
          ),
          SizedBox(
            height: 30,
          ),
          Text("참조 중인 TODO"),
          FutureBuilder(
            future: RefFuture(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var ref_list = [];
                //todo 비교하기
                for (var i = 0; i < snapshot.data!.length; i++) {
                  if (data.reference
                      .split(" ")
                      .contains(snapshot.data![i].id)) {
                    ref_list.add(snapshot.data![i].todo);
                  }
                }
                return Text(ref_list.toString());
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () async {
              List<bool> successTodo = [];
              Future<List<TodoModel>> getTodo = RefFuture().then(
                (value) {
                  for (var i = 0; i < value.length; i++) {
                    if (data.reference.split(" ").contains(value[i].id)) {
                      successTodo.add(value[i].success);
                    }
                  }
                  if (successTodo.contains(false)) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(ref_snackBar);
                    return value;
                  } else {
                    DataSuccess({
                      "date": data.date,
                      "id": data.id,
                      "reference": data.reference,
                      "success": !data.success,
                      "todo": data.todo
                    });
                    Navigator.pop(context);
                    return value;
                  }
                },
              );
            },
            child: Text(data.success == true ? "수정" : "완료")),
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
            child: Text("수정")),
        ElevatedButton(
            autofocus: _TodoTextController.text == "" ? false : true,
            onPressed: () async {
              List<bool> successTodo = [];
              Future<List<TodoModel>> getTodo = RefFuture().then(
                (value) {
                  for (var i = 0; i < value.length; i++) {
                    if (data.reference.split(" ").contains(value[i].id)) {
                      successTodo.add(value[i].success);
                    }
                  }
                  if (successTodo.contains(false)) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(ref_snackBar);
                    return value;
                  } else {
                    DataRemove(data);
                    Navigator.pop(context);
                    return value;
                  }
                },
              );
            },
            child: Text("삭제"))
      ],
    );
  }

  Future<List<TodoModel>> RefFuture() async {
    List<TodoModel> Id_list = [];
    await FirebaseFirestore.instance
        .collection("todos")
        .orderBy("add_date", descending: true)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          // 모델로 만들어서 리스트에 넣기
          Id_list.add(TodoModel.fromJson(
              todo: docSnapshot.data()["todo"],
              date: docSnapshot.data()["date"],
              id: docSnapshot.id,
              reference: docSnapshot.data()["reference"],
              success: docSnapshot.data()["success"]));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        print(Id_list);
      },
    );
    return Id_list;
  }
}
