import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/todolist/common/riverpod/addtodo_provider.dart';

class AddDate extends ConsumerWidget {
  const AddDate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(dateProvider);
    return Column(
      children: [
        Text("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"),
        ElevatedButton(
            onPressed: () {
              //날짜 입력 받기
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ).then((selectedDate) {
                ref
                    .read(dateProvider.notifier)
                    .update((state) => selectedDate!);
              });
            },
            child: const Text("날짜 변경"))
      ],
    );
  }
}
