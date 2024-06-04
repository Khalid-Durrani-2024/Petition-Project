import 'package:flutter/material.dart';

import '../Colors/Colors.dart';

class AddUniversity extends StatelessWidget {
  const AddUniversity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: UniversityScreen(),
    );
  }
}

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({super.key});

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  var _idController = TextEditingController();
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
                child: TextFormField(
                  enabled: false,
                  initialValue: '۴',
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
                      label: Text('د پوهنتون مسلسل شمیره')),
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
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    print('Handle Appropriate changes if the form is validate');
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
