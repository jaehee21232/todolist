import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';

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
            child: Text("참조넣기")),
      ],
    );
  }
}
