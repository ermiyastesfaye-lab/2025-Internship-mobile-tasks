import 'package:flutter/material.dart';
import 'package:task_7/pages/add_watch.dart';

import 'package:task_7/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/addproduct': (context) => const AddWatch(),
      },
    );
  }
}
