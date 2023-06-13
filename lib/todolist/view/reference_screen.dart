import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/common/layout/default_layout.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';

class ReferenceScreen extends StatelessWidget {
  const ReferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "참조 페이지",
      child: FutureBuilder(
        future: future(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!.length);
            print("요거임");
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data![index].id,
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<TodoModel>> future() async {
    List<TodoModel> testlist = [];
    await FirebaseFirestore.instance.collection("todos").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
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
