import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({super.key});

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Center(child: Text("검색")),
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "검색"),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("성공 여부")),
              ElevatedButton(onPressed: () {}, child: Text("날짜"))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 400,
              child: ElevatedButton(onPressed: () {}, child: Text("검색"))),
        ],
      ),
    );
  }

  SerachTrue() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
