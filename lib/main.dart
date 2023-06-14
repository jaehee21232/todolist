import 'package:flutter/material.dart';
import 'package:todolist/todolist/view/add_screen.dart';
import 'package:todolist/todolist/view/reference_screen.dart';
import 'package:todolist/todolist/view/splash%20_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolist/todolist/view/todolist_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoList',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 39, 89, 184)),
        useMaterial3: true,
      ),
      home: const TodoListScreen(),
      routes: {
        "/addscreen": (context) => const TodoAddScreen(),
        "/referenceScreen": (context) => const ReferenceScreen(),
      },
    );
  }
}
