import 'package:flutter/material.dart';
import 'package:task_7/features/product/presentation/pages/add_watch.dart';

import 'package:task_7/features/product/presentation/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android:
                FadeUpwardsPageTransitionsBuilder(), // For Android
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(), // For iOS
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/addproduct': (context) => const AddWatch(),
      },
    );
  }
}
