import 'package:flutter/material.dart';

AppBar? renderAppBar(title) {
  if (title == null) {
    return null;
  } else {
    return AppBar(
      title: Text(
        title!,
        style: TextStyle(
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
