import 'package:flutter/material.dart';

AppBar? renderAppBar(title) {
  return AppBar(
    title: Text(
      title!,
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
