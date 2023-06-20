import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final appBar;
  final Widget? floatingActionButton;
  const DefaultLayout(
      {super.key,
      this.appBar,
      required this.child,
      this.backgroundColor,
      this.bottomNavigationBar,
      this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
      backgroundColor: backgroundColor ?? Colors.white,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
