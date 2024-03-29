// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page/task_page.dart';
import 'state/task_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista de Tarefas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TaskPage(),
      ),
    );
  }
}
