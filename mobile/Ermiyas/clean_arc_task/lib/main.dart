import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_7/features/product/presentation/bloc/product_bloc.dart';
import 'package:task_7/features/product/presentation/pages/add_watch.dart';

import 'package:task_7/features/product/presentation/pages/home.dart';
import 'package:task_7/injection_container.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>(),
      child: MaterialApp(
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android:
                  FadeUpwardsPageTransitionsBuilder(), // For Android
              TargetPlatform.iOS:
                  FadeUpwardsPageTransitionsBuilder(), // For iOS
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(),
          '/addproduct': (context) => const AddWatch(),
        },
      ),
    );
  }
}
