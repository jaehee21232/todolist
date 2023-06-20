import 'package:flutter/material.dart';

class RefSnackBar extends StatelessWidget {
  final String text;
  const RefSnackBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(text),
    );
  }
}
