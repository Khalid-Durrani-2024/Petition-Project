import 'dart:html';

import 'package:flutter/material.dart';
import '../Colors/Colors.dart';
import '../models/ApiService.dart';
import '../models/Faculty.dart';

class Faculty extends StatelessWidget {
  const Faculty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: FacultyScreen(),
    );
  }
}

//Add Faculty

class FacultyScreen extends StatefulWidget {
  @override
  State<FacultyScreen> createState() => _FacultyScreenState();

}

List<String> universitiesInFaculty = [
  '...',

];
 List universitiesMap=[];
 int _selectedId=0;
TextEditingController _noFaculty=TextEditingController();
int _selectedFaculty=0;
getUniversities()async{
 var data= await ApiService().fetchData('universities');
  for(int i=0;i<data.length;i++){
    universitiesInFaculty.add(data[i]['name']);
    universitiesMap.add(data[i]);
  }

}
getFaculties()async{
  try{
    var data=await ApiService().fetchData('faculty');
    if(data!=null){

      for(int i=0;i<data.length;i++){

       _selectedFaculty=int.parse(data[i]['id']);

      }
      print(_selectedFaculty);
      _noFaculty.text=_selectedFaculty.toString();
    }else{
      print('No Data Found');
    }
  }catch(e){
    print(e.toString());
  }
}
String _selectedUniversity = universitiesInFaculty.first;
bool hoverChange = false;

class _FacultyScreenState extends State<FacultyScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  getUniversities();
  getFaculties();
}
  final _formKey = GlobalKey<FormState>();
 TextEditingController facultyController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();

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
                //Faculty ID Field
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(

                  controller: _noFaculty,

                      readOnly: true,
                  validator: (value) {},
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                      label:_noFaculty.text!=''? Text('د پوهنځي مسلسله شمیره'):Icon(Icons.error_outline,color: colors.helperWhiteColor,)),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              //Faculty Name
              Container(
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(
controller: facultyController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'د پوهنځي نوم دننه کړۍ';
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
                      label: Text('پوهنځي نوم')),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              //University Selection
              Container(
                width: width / 2,
                child: DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(22),
                  decoration: InputDecoration(
                      label: Text(' پوهنتون'),
                      labelStyle: TextStyle(color: colors.helperWhiteColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      fillColor: colors.textFieldColor,
                      filled: true),
                  dropdownColor: colors.backgroundColor,
                  isExpanded: true,
                  hint: Text('انتخاب کړۍ'),
                  validator: (value) {
                    if (value!.isEmpty ||
                        value == '' ||
                        value == universitiesInFaculty.first) {
                      return 'د پوهنتون نوم انتخاب کړۍ';
                    }
                  },
                  value: _selectedUniversity,
                  items: universitiesInFaculty.map((String e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                          color: colors.helperWhiteColor,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (cha) {
                    _selectedUniversity = cha!;
                    for(int i=0;i<universitiesMap.length;i++){
                      if(universitiesMap[i]['name']==cha){

                        _selectedId=int.parse(universitiesMap[i]['id']);


                        break;

                      }
                    }

                    },
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                //Email Field
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'ایمیل ادرس مو دننه کړۍ';
                    } else if (!value.contains('@')) {
                      return 'خپل ایمیل ادرس مو چیک کړۍ او بیا هڅه وکړۍ "@"';
                    } else if (!value.contains('.')) {
                      return 'خپل ایمیل ادرس مو چیک کړۍ او بیا هڅه وکړۍ "."';
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
                      label: Text('ایمیل')),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              //Password Section
              Container(
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(
                  controller:passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'پټ نوم دننه کړۍ';
                    }
                    return null;
                  },
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                      label: Text('پټ نوم')),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onHover: (value) {
                    setState(() {
                      hoverChange = value;
                    });
                  },
                  onTap: () {
                    if (_formKey.currentState!.validate()) {


                  final faculty=  FacultyModel(
                      name: facultyController.text,
                      university_id:_selectedId,
                      email: emailController.text,
                      password: passwordController.text,
                      university_name: _selectedUniversity,
                      role: 'Faculty');
                    ApiService().sendFaculty(faculty, 'faculty');

                      print(
                          'Handle Appropriate changes if the form is validate $_selectedUniversity');
                    }
                  },
                  //Log In Button
                  child: hoverChange ? LogInButton() : LogInButtonDefault()),
            ],
          )),
    );
  }
}

//Button to Log In Outlined Theme
class LogInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: colors.hoverColor,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      width: width / 5,
      height: height / 15,
      child: Text(
        'ثبت کړۍ',
        style: TextStyle(
            color: colors.hoverColor,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }
}

//Button default theme
class LogInButtonDefault extends StatelessWidget {
  const LogInButtonDefault({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.buttonColor,
        borderRadius: BorderRadius.circular(22),
      ),
      width: width / 5,
      height: height / 15,
      child: const Text(
        'ثبت کړۍ',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
