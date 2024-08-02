
import 'package:flutter/material.dart';
import '../Screens/Admin.dart';
import  '../Screens/Login.dart';
import '../Screens/Maktob.dart';
import '../models/ApiService.dart';

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
   }else if(data['role']=='Faculty'){
     return 'Faculty';
   }else if(data['role']=='university'){
     return 'university';
   }
   else{
     return null;
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
          print('admin Navigation done');
          return Admin();
        }else if(snapshot.data=='Faculty'){
          print('returning Faculty');
          return Maktob(index:10);
        }else if(snapshot.data=='university'){
          print('returning university');
          return Maktob(index: 9);
        }
        else {
          return Login();
        }
      },
    );
  }
}
