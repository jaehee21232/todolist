import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/common/layout/default_layout.dart';
import 'package:todolist/todolist/common/component/custom_tile.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';
import 'package:todolist/todolist/common/riverpod/addtodo_provider.dart';

class ReferenceScreen extends ConsumerWidget {
  const ReferenceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TodoModel> referenceTodo = [];
    AddReference(TodoModel todo) {
      referenceTodo.add(todo);
    }

    RemoveReference(TodoModel todo) {
      referenceTodo.remove(todo);
    }

    return DefaultLayout(
      title: "참조 페이지",
      child: Stack(children: [
        FutureBuilder(
          future: future(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Custom_ListTile(
                    todo: snapshot.data![index],
                    AddRef: AddReference,
                    RemoveRef: RemoveReference,
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Positioned(
          bottom: 35,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: SizedBox(
            width: 100,
            child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(referenceProvider.notifier)
                      .update((state) => referenceTodo);
                  Navigator.pop(context);
                },
                child: Text("확인")),
          ),
        )
      ]),
    );
  }

  Future<List<TodoModel>> future() async {
    List<TodoModel> testlist = [];
    //다 가져오기
    await FirebaseFirestore.instance
        .collection("todos")
        .orderBy("add_date", descending: true)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          // 모델로 만들어서 리스트에 넣기
          testlist.add(TodoModel.fromJson(
              todo: docSnapshot.data()["todo"],
              date: docSnapshot.data()["date"],
              id: docSnapshot.id,
              reference: docSnapshot.data()["reference"],
              success: docSnapshot.data()["success"]));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        print(testlist);
      },
    );
    return testlist;
  }
}
