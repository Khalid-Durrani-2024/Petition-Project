import 'package:flutter/material.dart';
import 'package:petition/Screens/Login.dart';
import 'package:petition/Screens/Maktob.dart';
import 'package:petition/models/ApiService.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

ApiService _apiService = new ApiService();

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _apiService.fetchData('admin'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Maktob();
        } else {
          return Login();
        }
      },
    );
  }
}
