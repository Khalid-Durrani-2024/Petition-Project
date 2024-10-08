import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ApiService.dart';
class AuthData{
  List users=[];
    //login in user
  authentication(String email,String password,String type)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var data;
    try {
      if(type=='وزارت'){
        data = await ApiService().fetchData('admin');
      }else if(type=='پوهنتون'){
        data = await ApiService().fetchData('users');

      }else if(type=='پوهنځی'){
        data = await ApiService().fetchData('faculty');

      }

      //checking user
      for(int i=0;i<data.length;i++){
        users.add(data[i]);
      }

      users.forEach((element) {

        if(element['email']==email){

          if(element['password']==password){

            pref.setString('User', jsonEncode(element));
            return jsonDecode(element);

          }

        }
      });
    }catch(e){
      print(e.toString());
    }
  }
//loging out user
  deleteShared()async{
    var data=  await SharedPreferences.getInstance();
    var dd=data.remove('User');
  }


  getSharedData()async{
    var data=  await SharedPreferences.getInstance();
    var user=data.get("User");
    var naturalData=jsonDecode(user.toString());
    return naturalData;
  }

}