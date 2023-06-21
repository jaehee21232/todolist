import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/todolist/common/component/todo_block.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  Future<QuerySnapshot>? futureSearchResults;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Center(child: Text("검색")),
      content: Column(
        children: [
          TextFormField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: "검색",
            ),
            onFieldSubmitted: searchTodo,
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 400,
              child: ElevatedButton(
                  onPressed: () {
                    searchTodo(textController.text);
                  },
                  child: const Text("검색"))),
          futureSearchResults == null ? const Text("") : searchTrue()
        ],
      ),
    );
  }

  searchTodo(str) {
    Future<QuerySnapshot> allTodos = FirebaseFirestore.instance
        .collection("todos")
        .where("todo", isEqualTo: str)
        .get();
    setState(() {
      futureSearchResults = allTodos;
    });
  }

  searchTrue() {
    return FutureBuilder(
      future: futureSearchResults,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.data!.docs.isEmpty) {
            return const Text("검색 결과 없음");
          } else {
            TodoModel data = TodoModel.fromJson(
              todo: snapshot.data!.docs[0]["todo"],
              date: snapshot.data!.docs[0]["date"],
              id: snapshot.data!.docs[0]["id"],
              reference: snapshot.data!.docs[0]["reference"],
              success: snapshot.data!.docs[0]["success"],
            );
            return TodoBlock(data: data);
          }
        }
      },
    );
  }
}
