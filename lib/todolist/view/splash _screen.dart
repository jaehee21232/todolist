import 'package:flutter/material.dart';
import 'package:todolist/common/layout/default_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
