import 'package:flutter/material.dart';
import 'package:petition/Screens/UniversityAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Authentication/AuthWrapper.dart';

initializingAutomaticBackup() async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  shr.setInt('time', DateTime.now().hour);
  print('Autmatic Backup initialized');
}

void main() {
  runApp(const MyApp());
  initializingAutomaticBackup();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petitions',
      home: AuthWrapper(),
    );
  }
}
