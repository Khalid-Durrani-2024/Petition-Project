import 'package:flutter/material.dart';
import 'package:petition/models/ApiService.dart';
import 'package:petition/models/UniversityModel.dart';

import '../Colors/Colors.dart';

class AddUniversity extends StatelessWidget {
  const AddUniversity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.textFieldColor,
        centerTitle: true,
        title: Text('پوهنتون اضافه کړۍ'),
      ),
      backgroundColor: colors.backgroundColor,
      body: UniversityScreen(),
    );
  }
}











//adding university in database
class UniversityScreen extends StatefulWidget {
  const UniversityScreen({super.key});

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

String id='';
class _UniversityScreenState extends State<UniversityScreen> {
  _getUniversities()async{
 List universities= await ApiService().fetchData('universities');
  for(int i=0;i<universities.length;i++){
   id=universities[i]['id'];
  }
  return id;
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  _getUniversities();
  }
  TextEditingController universityNameController=TextEditingController();
  TextEditingController universityLocationController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //University ID Field
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: FutureBuilder(
                  future: _getUniversities(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child:CircularProgressIndicator());
                    }else if(snapshot.hasError){
                      return Center(child: Icon(Icons.error_outline_outlined,color: colors.helperWhiteColor,),);
                    }
                    else{
                   return TextFormField(
                          initialValue: snapshot.data.toString(),
                     enabled: false,

                     validator: (value) {

                     },
                     keyboardType: TextInputType.emailAddress,
                     style: TextStyle(color: Colors.white),
                     decoration: InputDecoration(
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(22)),
                         labelStyle: TextStyle(
                             color: Colors.white,
                             fontSize: 12,
                             fontWeight: FontWeight.w100),
                         label: Text('د پوهنتون مسلسل شمیره')),
                   );
                    }
                  },

                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(
                  controller: universityNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'د پوهنتون نوم دننه کړۍ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                      label: Text('پوهنتون نوم')),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(
                  controller: universityLocationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'د پوهنتون موقعیت (ځای) دننه کړۍ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                      label: Text('پوهنتون موقعیت')),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              InkWell(

                onTap: () async{

                  if (_formKey.currentState!.validate()) {
                    final university=UniversityModel(name: universityNameController.text,
                        location: universityLocationController.text,
                        created_at: DateTime.now().toString().substring(0,10));
                 var response=await ApiService().sendUniversity(university, 'universities');
                   if(response==201){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('پوهنتون اضافه شو')));
                    Navigator.pop(context);
                   }else{
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Icon(Icons.error_outline,color: Colors.red,)));

                   }
                  }
                },
                //Log In Button
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: colors.buttonColor),
                  width: width / 5,
                  height: height / 15,
                  child: const Text(
                    'ثبت کړۍ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
