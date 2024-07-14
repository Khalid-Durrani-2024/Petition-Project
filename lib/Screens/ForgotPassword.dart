import 'package:flutter/material.dart';
import 'package:petition/Colors/Colors.dart';
import 'package:petition/models/ApiService.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: ForgotPasswordForm(),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  List<String> _users = ['...', 'وزارت', 'پوهنتون', 'پوهنځی'];
  String checkingUser = '';
  String _selectedType = '';

  checkIfUserExists() async {
    List response = await ApiService().fetchData(checkingUser);
    response.forEach((element) {
      if (element['email'] == emailController.text) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('استعمالوونکی پیدا شو'),
              content: Column(
                children: [
                  Text(
                    ' ${element['email']}:ایمیل',
                    style: TextStyle(color: colors.helperWhiteColor),
                  ),
                  Text(
                    '${element['password']}:پټ نوم',
                    style: TextStyle(color: colors.helperWhiteColor),
                  ),
                ],
              ),
              backgroundColor: colors.backgroundColor,
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close))
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            backgroundColor: Colors.red,
            content: Text('په دی ایمیل استعمالوونکی نشته'),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedType = _users.first;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // Email Field
              decoration: BoxDecoration(
                color: colors.textFieldColor,
                borderRadius: BorderRadius.circular(22),
              ),
              width: width / 2,
              child: TextFormField(
                style: TextStyle(color: colors.helperWhiteColor),
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مهرباني وکړۍ ایمیل دننه کړۍ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: colors.helperWhiteColor),
                  hintText: 'ایمیل ادرس مو دننه کړۍ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height / 30,
            ),
            Container(
              width: width / 2,
              child: DropdownButtonFormField<String>(
                borderRadius: BorderRadius.circular(22),
                decoration: InputDecoration(
                    label: Text(' یوزر نوعه'),
                    labelStyle: TextStyle(color: colors.helperWhiteColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22)),
                    fillColor: colors.textFieldColor,
                    filled: true),
                dropdownColor: colors.backgroundColor,
                isExpanded: true,
                hint: Text('انتخاب کړۍ'),
                validator: (value) {
                  if (value!.isEmpty || value == '' || value == _users.first) {
                    return 'د یوزر نوعه انتخاب کړۍ انتخاب کړۍ';
                  }
                },
                value: _selectedType,
                items: _users.map((String e) {
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
                  _selectedType = cha!;
                  if (_selectedType == 'وزارت') {
                    checkingUser = 'admin';
                  } else if (_selectedType == 'پوهنتون') {
                    checkingUser = 'users';
                  } else if (_selectedType == 'پوهنځی') {
                    checkingUser = 'faculty';
                  }
                },
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  checkIfUserExists();
                }
              },
              // Reset Password Button
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: colors.buttonColor,
                ),
                width: width / 5,
                height: height / 15,
                child: const Text(
                  'پاسورډ حذف کړۍ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: height / 30),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                'وروسته تګ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
