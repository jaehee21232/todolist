import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';

final db = FirebaseFirestore.instance;

test(DateTime date, String todo, bool success, List<TodoModel> references) {
  final reference = [];
  for (var i = 0; i < references.length; i++) {
    reference.add(references[i].id);
  }
  db.collection("todos").doc().set({
    "date": date,
    "todo": todo,
    "success": success,
    "reference": reference,
  });
}
