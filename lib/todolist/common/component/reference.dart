import 'package:flutter/material.dart';

class AddReference extends StatelessWidget {
  const AddReference({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              Navigator.pushNamed(context, "/referenceScreen");
            },
            child: const Text("참조넣기")),
      ],
    );
  }
}
