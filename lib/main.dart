import 'package:flutter/material.dart';
import 'package:petition/Authentication/AuthWrapper.dart';
import 'package:petition/Widgets/testing.dart';

import 'Screens/Faculty.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petitions',
      home: AuthWrapper(),
    );
  }
}
