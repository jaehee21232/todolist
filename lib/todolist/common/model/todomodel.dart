class TodoModel {
  final String todo;
  final String reference;
  final String date;
  final bool success;
  final String id;

  TodoModel(
      {this.todo = "",
      this.reference = "",
      this.date = "",
      this.success = false,
      this.id = ""});

  factory TodoModel.fromJson(
      {required String todo, reference, date, success, id}) {
    return TodoModel(
        date: date, reference: reference, todo: todo, success: success, id: id);
  }

  factory TodoModel.fromMap({required Map<String, dynamic> map}) {
    return TodoModel(
        todo: map["todo"],
        date: map["date"],
        id: map["id"],
        reference: map["reference"],
        success: map["success"]);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data["reference"] = reference;
    data["todo"] = todo;
    data["success"] = success;
    data["date"] = date;
    data["id"] = id;
    data["add_date"] = DateTime.now();
    return data;
  }
}
