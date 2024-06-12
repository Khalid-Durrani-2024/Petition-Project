import 'package:flutter/material.dart';

import '../Colors/Colors.dart';

UpdateUniversity(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  List<String> _universities = ['۱', '۲', '۳', '۴', '۵', '۶', '۷'];
  String _selectedUniversity = _universities.first;
  var UnameController = TextEditingController();
  var UlocationController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: colors.backgroundColor,
        title: Container(
          padding: const EdgeInsets.all(20),
          width: 800,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  dropdownColor: colors.backgroundColor,
                  isExpanded: true,
                  hint: Text('انتخاب کړۍ'),
                  validator: (value) {
                    if (value!.isEmpty && value == '') {
                      return 'د پوهنتون مسلسله شماره اتنخاب کړۍ';
                    }
                  },
                  value: _selectedUniversity,
                  items: _universities.map((String e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(color: colors.helperWhiteColor),
                      ),
                    );
                  }).toList(),
                  onChanged: (cha) {},
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  //Universitiy name controller field
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: colors.helperWhiteColor),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          label: Text('پوهنتون'),
                          labelStyle: TextStyle(
                              color: colors.helperWhiteColor, fontSize: 12),
                        ),
                        controller: UnameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "د پوهنتون نوم دننه کړۍ";
                          }
                        },
                      ),
                    ),
                    Text(
                      'پوهنتون نوم',
                      style: TextStyle(color: colors.helperWhiteColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  //Universitiy Location controller field
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: colors.helperWhiteColor),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          label: Text('موقعیت'),
                          labelStyle: TextStyle(
                              color: colors.helperWhiteColor, fontSize: 12),
                        ),
                        controller: UlocationController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "د پوهنتون موقعیت دننه کړۍ";
                          }
                        },
                      ),
                    ),
                    Text(
                      'پوهنتون موقعیت',
                      style: TextStyle(color: colors.helperWhiteColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  //Buttons for Form
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('Form Valid Do appropriate Changes');
                        }
                      },
                      icon: Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ConfirmationDialog(context);
                        }
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

ConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: colors.backgroundColor,
        contentTextStyle: TextStyle(color: colors.helperWhiteColor),
        title: Icon(
          Icons.warning_amber_outlined,
          color: Colors.red,
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'غواړۍ چی پوهنتون حذف کړۍ',
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  print('Do the Deletition of the university');
                },
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
