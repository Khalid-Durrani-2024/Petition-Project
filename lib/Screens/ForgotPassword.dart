import 'package:flutter/material.dart';
import 'package:petition/Colors/Colors.dart';
import 'package:petition/models/ApiService.dart';
import 'package:petition/Assets/NetworkImages.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 223, 223),
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
  List<String> _users = ['د یوزر نوع انتخاب کړی', 'وزارت', 'پوهنتون', 'پوهنځی'];
  String checkingUser = '';
  String _selectedType = '';
  bool isHover = false;

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
                mainAxisSize: MainAxisSize.min,
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
                  child: Icon(Icons.close, color: colors.helperWhiteColor),
                )
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                width: width * 0.4,
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(ministryImage),
                      ),
                    ),
                    const Text(
                      'پټ نوم مو هیر دی؟',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: height / 30),
                    Container(
                      width: width * 0.8,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
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
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                          border: InputBorder.none,
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          label: Text('ایمیل'),
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                    SizedBox(height: height / 30),
                    Container(
                      width: width * 0.3,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: DropdownButtonFormField<String>(
                        borderRadius: BorderRadius.circular(22),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // icon: Icon(Icons.arrow_drop_down),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                        ),
                        dropdownColor: Colors.grey.shade300,
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
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (cha) {
                          setState(() {
                            _selectedType = cha!;
                            if (_selectedType == 'وزارت') {
                              checkingUser = 'admin';
                            } else if (_selectedType == 'پوهنتون') {
                              checkingUser = 'users';
                            } else if (_selectedType == 'پوهنځی') {
                              checkingUser = 'faculty';
                            }
                          });
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
                      onHover: (val) {
                        setState(() {
                          isHover = val;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: isHover ? Colors.blue.shade700 : Colors.blue,
                          boxShadow: isHover
                              ? [
                            BoxShadow(
                              color: Colors.blue.shade300,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            )
                          ]
                              : [],
                        ),
                        width: width * 0.2,
                        height: height / 15,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: const Text(
                              'پاسورډ معلوم کړی',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
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
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
