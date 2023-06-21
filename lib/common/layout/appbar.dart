import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  const CommonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevation: 1,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      centerTitle: true,
    );
  }
}
