import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';

final dateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);
final todoProvider = StateProvider<String>(
  (ref) => "todo",
);
final referenceProvider = StateProvider<List<TodoModel>>((ref) => []);
