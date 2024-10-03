import 'package:flutter/material.dart';
import 'package:flutter_workshop_demo/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade400),
        useMaterial3: true,
      ),
      home: const HomeScreen(title: 'TODO App'),
    );
  }
}
