import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/todolist/common/riverpod/addtodo_provider.dart';
import 'package:todolist/todolist/firebase/firestore.dart';

class AddButton extends ConsumerWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final todo = ref.watch(todoProvider);
    final reference = ref.watch(referenceProvider);
    return ElevatedButton(
        onPressed: () {
          if (todo == "None" || todo == "") {
          } else {
            DataAdd(date, todo, false, reference);
            Navigator.pop(context);
          }
        },
        child: const Text("추가하기"));
  }
}
