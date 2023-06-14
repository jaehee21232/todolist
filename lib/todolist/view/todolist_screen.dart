import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/common/layout/default_layout.dart';
import 'package:todolist/todolist/common/component/custom_tile.dart';
import 'package:todolist/todolist/common/component/reference.dart';
import 'package:todolist/todolist/common/component/todo_block.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "TodoList",
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/addscreen");
          },
        ),
        child: StreamBuilder(
          stream: streamTodo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final doc = snapshot.data.docs[index];
                  final data = TodoModel.fromJson(
                      todo: doc["todo"],
                      date: doc["date"],
                      id: snapshot.data.docs[index].id,
                      reference: doc["reference"],
                      success: doc["success"]);
                  print(data);
                  return TodoBlock(data: data);
                },
              );
            }
          },
        ));
  }

  Stream streamTodo() {
    try {
      final Stream<QuerySnapshot> snapshot = FirebaseFirestore.instance
          .collection("todos")
          .orderBy("add_date", descending: true)
          .snapshots();

      return snapshot;
    } catch (ex) {
      log('error)', error: ex.toString(), stackTrace: StackTrace.current);
      return Stream.error(ex.toString());
    }
  }
}
