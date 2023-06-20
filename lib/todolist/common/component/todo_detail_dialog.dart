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
    TextEditingController todoTextController =
        TextEditingController(text: data.todo);
    DateTime selectedDate = ref.watch(dateProvider);

    return AlertDialog(
      //모서리 둥글게
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(child: Text(data.todo)),
      content: Column(
        children: [
          Text("ID : ${data.id}"),
          Text(
              "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"),
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
              child: const Text("날짜 변경")),
          //todo 변경
          TextField(
            decoration: const InputDecoration(hintText: "TODO를 적어주세요!"),
            controller: todoTextController,
            onChanged: (value) {
              print(todoTextController.text);
            },
          ),
          const SizedBox(
            height: 30,
          ),
          const Text("참조 중인 TODO"),
          FutureBuilder(
            future: RefFuture(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var refList = [];
                //todo 비교하기
                for (var i = 0; i < snapshot.data!.length; i++) {
                  if (data.reference
                      .split(" ")
                      .contains(snapshot.data![i].id)) {
                    refList.add(snapshot.data![i].todo);
                  }
                }
                return Text(refList.toString());
              } else {
                return const CircularProgressIndicator();
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
              RefFuture().then(
                (value) {
                  for (var i = 0; i < value.length; i++) {
                    if (data.reference.split(" ").contains(value[i].id)) {
                      successTodo.add(value[i].success);
                    }
                  }
                  if (successTodo.contains(false)) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        RefSnackBar(text: "참조중인 TODO가 완료 안됨!") as SnackBar);
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
            child: Text(data.success == true ? "미완료" : "완료")),
        ElevatedButton(
            onPressed: () {
              if (todoTextController.text == "") {
                return null;
              } else {
                //model로 보내기 위해서 todo만 change된 값으로 다시 만들어서 보냄
                final replacedata = TodoModel(
                    date: selectedDate.toString(),
                    id: data.id,
                    reference: data.reference,
                    success: data.success,
                    todo: todoTextController.text);
                DataReplace(replacedata);
                Navigator.pop(context);
              }
            },
            child: const Text("수정")),
        ElevatedButton(
            autofocus: todoTextController.text == "" ? false : true,
            onPressed: () async {
              List<bool> successTodo = [];
              RefFuture().then(
                (value) {
                  for (var i = 0; i < value.length; i++) {
                    if (data.reference.split(" ").contains(value[i].id)) {
                      successTodo.add(value[i].success);
                    }
                  }
                  if (successTodo.contains(false)) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        RefSnackBar(text: "참조중인 TODO가 완료 안됨!") as SnackBar);
                    return value;
                  } else {
                    DataRemove(data);
                    Navigator.pop(context);
                    return value;
                  }
                },
              );
            },
            child: const Text("삭제"))
      ],
    );
  }

  Future<List<TodoModel>> RefFuture() async {
    List<TodoModel> idList = [];
    await FirebaseFirestore.instance
        .collection("todos")
        .orderBy("add_date", descending: true)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          // 모델로 만들어서 리스트에 넣기
          idList.add(TodoModel.fromJson(
              todo: docSnapshot.data()["todo"],
              date: docSnapshot.data()["date"],
              id: docSnapshot.id,
              reference: docSnapshot.data()["reference"],
              success: docSnapshot.data()["success"]));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        print(idList);
      },
    );
    return idList;
  }
}
