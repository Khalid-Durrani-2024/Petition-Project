
import 'package:flutter/material.dart';
import 'package:petition/Screens/Admin.dart';
import 'package:petition/Screens/Login.dart';
import 'package:petition/Screens/Maktob.dart';
import 'package:petition/models/ApiService.dart';

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
  Future authenticate()async{
  var data=await AuthData().getSharedData();
   if(data['role']=='admin'){
     return 'admin';
   }else{
     return 'user';
   }
 }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authenticate(),
      builder: (context, snapshot) {

        if (snapshot.connectionState==ConnectionState.waiting) {

          return Center(child: CircularProgressIndicator(),);

        }else if(snapshot.data=='admin'){
          return Admin();
        }else if(snapshot.hasData){
          return Maktob(index:0);
        }
        else {
          return Login();
        }
      },
    );
  }
}
