import 'package:flutter/material.dart';
import 'package:petition/Authentication/AuthWrapper.dart';
import 'package:petition/Screens/Faculty.dart';
import 'package:petition/Screens/Login.dart';
import '../Screens/Maktob.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petitions',
      home: Maktob(),
    );
  }
}
