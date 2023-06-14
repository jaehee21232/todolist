import 'package:flutter/material.dart';
import 'package:todolist/todolist/common/model/todomodel.dart';

class Custom_ListTile extends StatefulWidget {
  final TodoModel todo;
  final Function AddRef;
  final Function RemoveRef;
  const Custom_ListTile(
      {super.key,
      required this.todo,
      required this.AddRef,
      required this.RemoveRef});

  @override
  State<Custom_ListTile> createState() => _Custom_ListTileState();
}

class _Custom_ListTileState extends State<Custom_ListTile> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          select = !select;
          if (select == true) {
            widget.AddRef(widget.todo);
          } else {
            widget.RemoveRef(widget.todo);
          }
        });
      },
      child: Container(
        decoration:
            BoxDecoration(color: select ? Colors.blue[200] : Colors.white),
        width: double.infinity,
        height: 50,
        child: Align(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              widget.todo.todo,
              style: TextStyle(fontSize: 14),
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}
