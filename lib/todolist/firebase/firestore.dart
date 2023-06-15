import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';

final db = FirebaseFirestore.instance;

DataAdd(DateTime date, String todo, bool success, List<TodoModel> references) {
  DateTime today = DateTime.now();
  final reference = [];
  for (var i = 0; i < references.length; i++) {
    reference.add(references[i].id);
  }
  db.collection("todos").doc().set({
    "add_date": today.toString(),
    "date": "${date.year}-${date.month}-${date.day}",
    "todo": todo,
    "success": success,
    "reference":
        //[ , ] 제거
        reference.toString().replaceAll(RegExp('[^a-zA-Z0-9가-힣\\s]'), ""),
  });
}

DataRemove(TodoModel data) {
  db.collection("todos").doc(data.id).delete();
}

DataReplace(TodoModel data) {
  print(data.toMap());
  db.collection("todos").doc(data.id).set(data.toMap());
}

DataSuccess(Map<String, Object> map) {
  print(map);
  db.collection("todos").doc(map["id"].toString()).update(map);
}
