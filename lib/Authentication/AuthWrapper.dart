import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petition/Screens/Admin.dart';
import 'package:petition/Screens/Login.dart';
import 'package:petition/models/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AuthData.dart';
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

ApiService _apiService = new ApiService();

class _AuthWrapperState extends State<AuthWrapper> {


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthData().getSharedData();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthData().getSharedData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          return Admin();

        } else {
          return Login();
        }
      },
    );
  }
}
