import 'package:flutter/material.dart';
import 'package:petition/Screens/AddUniversities.dart';
import 'package:petition/Screens/AddUser.dart';
import 'package:petition/Screens/Admin.dart';
import 'package:petition/Screens/Faculty.dart';
import 'package:petition/Screens/Login.dart';
import 'package:petition/Screens/Universities.dart';

import '../Colors/Colors.dart';

class Maktob extends StatefulWidget {
  const Maktob({super.key});

  @override
  State<Maktob> createState() => _MaktobState();
}

class _MaktobState extends State<Maktob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.textFieldColor,
      ),
      drawer: Drawer(
        backgroundColor: colors.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                label: Text('Login Screen'),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Admin(),
                    ),
                  );
                },
                label: Text('Admin Screen'),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUniversity(),
                    ),
                  );
                },
                label: Text('Add University Screen'),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Maktob(),
                    ),
                  );
                },
                label: Text('Maktob Screen'),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Universities(),
                    ),
                  );
                },
                label: Text('Universities Screen'),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUser(),
                    ),
                  );
                },
                label: Text('Add User'),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Faculty(),
                    ),
                  );
                },
                label: Text('Add Faculty'),
              ),
            ],
          ),
        ),
      ),
      body: maktobScreen(),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.buttonColor,
        onPressed: () {
          Write(context);
          setState(() {});
        },
        label: const Icon(Icons.create),
      ),
    );
  }
}

//sample of petitions
final List<Map> Petitions = [
  {
    'id': '۱',
    'Date': '۱۴۰۳ - ۰۳ - ۰۱',
    'Sender': 'علی',
    'Text':
        'د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته '
  },
  {
    'id': '۲',
    'Date': '۱۴۰۳ - ۰۳ - ۰۱',
    'Sender': 'جان',
    'Text':
        'د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته '
  },
  {
    'id': '۳',
    'Date': '۱۴۰۳ - ۰۳ - ۰۱',
    'Sender': 'ذاهد',
    'Text':
        'د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته '
  },
  {
    'id': '۴',
    'Date': '۱۴۰۳ - ۰۳ - ۰۱',
    'Sender': 'خان',
    'Text':
        'د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته '
  },
  {
    'id': '۵',
    'Date': '۱۴۰۳ - ۰۳ - ۰۱',
    'Sender': 'خان',
    'Text':
        'د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته '
  },
  {
    'id': '۶',
    'Date': '۱۴۰۳ - ۰۳ - ۰۱',
    'Sender': 'خان',
    'Text':
        'د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته '
  },
  {
    'id': '۷',
    'Date': '۱۴۰۳ - ۰۳ - ۰۱',
    'Sender': 'خان',
    'Text':
        'د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته د سید جمالدین افغانی پوهنتون ته '
  },
];

//maktob screen
class maktobScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
        padding: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(color: colors.backgroundColor),
        width: width,
        height: height,
        child: ListView.builder(
          itemCount: Petitions.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                //showing maktob from button
                Sheet(context, index);
              },
              child: Card(
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                color: colors.textFieldColor,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Petitions[index]['Sender'],
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                      Text(Petitions[index]['Date'],
                          style: TextStyle(
                              fontSize: 12, color: colors.helperWhiteColor)),
                    ],
                  ),
                  subtitle: Text(
                    Petitions[index]['Text'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: colors.helperWhiteColor),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: colors.buttonColor, shape: BoxShape.circle),
                    width: width / 15,
                    height: height / 15,
                    child: Text(
                      Petitions[index]['id'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: colors.helperWhiteColor),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

//Showing Maktob

Sheet(BuildContext context, int no) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: colors.backgroundColor,
        content: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: colors.helperWhiteColor,
                        ))
                  ],
                ),
                Text(
                  "نمبر مکتوب: " + Petitions[no]['id'],
                  style:
                      TextStyle(color: colors.helperWhiteColor, fontSize: 20),
                ),
                Text(
                  "تاریخ: " + Petitions[no]['Date'],
                  style:
                      TextStyle(color: colors.helperWhiteColor, fontSize: 20),
                ),
                Text(
                  "لیږوونکی: " + Petitions[no]['Sender'],
                  style:
                      TextStyle(color: colors.helperWhiteColor, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Petitions[no]['Text'],
                  style: TextStyle(color: colors.helperWhiteColor),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

//Creating new maktob

Write(BuildContext context) {
  var noController = TextEditingController();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  return showModalBottomSheet(
      context: context,
      builder: (index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: colors.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              )),
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    //Drop Down List
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          dropdownColor: colors.buttonColor,
                          alignment: Alignment.centerRight,
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                'مکتوب',
                                style:
                                    TextStyle(color: colors.helperWhiteColor),
                              ),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                      Text(
                        'د مکتوب نوعه انتخاب کړۍ',
                        style: TextStyle(color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  Row(
                    //DateTime

                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      showDate(),
                      Text(
                        'تاریخ',
                        style: TextStyle(color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  //title
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            label: Text('د مکتوب عنوان'),
                            labelStyle: TextStyle(
                                color: colors.helperWhiteColor, fontSize: 12),
                          ),
                          style: TextStyle(color: colors.helperWhiteColor),
                          controller: titleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'د مکتوب عنوان ولیکۍ';
                            }
                          },
                        ),
                      ),
                      Text(
                        'عنوان',
                        style: TextStyle(color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  //Description
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: colors.helperWhiteColor),
                          maxLines: 5,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            label: Text('د مکتوب تشریح'),
                            labelStyle: TextStyle(
                                color: colors.helperWhiteColor, fontSize: 12),
                          ),
                          controller: descriptionController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "د مکتوب تشریح ولیکۍ";
                            }
                          },
                        ),
                      ),
                      Text(
                        'ډیسکریبشن',
                        style: TextStyle(color: colors.helperWhiteColor),
                      )
                    ],
                  ),
                  //Reciever
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    //Drop Down List Reciever
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownMenu(
                        width: MediaQuery.of(context).size.width / 4,
                        menuStyle: MenuStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(colors.buttonColor)),
                        leadingIcon: Icon(
                          Icons.school_outlined,
                          color: colors.helperWhiteColor,
                        ),
                        textStyle: TextStyle(color: colors.helperWhiteColor),
                        label: Text(
                          'انتخاب کړۍ',
                          style: TextStyle(color: colors.helperWhiteColor),
                        ),
                        dropdownMenuEntries: [
                          DropdownMenuEntry(
                              style: ButtonStyle(
                                foregroundColor: MaterialStatePropertyAll(
                                    colors.helperWhiteColor),
                              ),
                              value: Text('Maktob'),
                              label: 'کابل پوهنتون'),
                          DropdownMenuEntry(
                              style: ButtonStyle(
                                foregroundColor: MaterialStatePropertyAll(
                                    colors.helperWhiteColor),
                              ),
                              value: Text('Maktob'),
                              label: 'ننګرهار پوهنتون'),
                          DropdownMenuEntry(
                              style: ButtonStyle(
                                foregroundColor: MaterialStatePropertyAll(
                                    colors.helperWhiteColor),
                              ),
                              value: Text('Maktob'),
                              label: 'کنړ پوهنتون'),
                        ],
                      ),
                      Text(
                        'د مکتوب ترلاسه کوونکی اداره',
                        style: TextStyle(color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: FloatingActionButton.extended(
                      backgroundColor: colors.buttonColor,
                      foregroundColor: colors.helperWhiteColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('Form is Valid');
                        }
                      },
                      label: Text('مکتوب ولیګۍ'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

//show DatePickerDialog
class showDate extends StatefulWidget {
  const showDate({super.key});

  @override
  State<showDate> createState() => _showDateState();
}

var dateTime = DateTime.now();

class _showDateState extends State<showDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          showDatePicker(
                  context: context,
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2030))
              .then((value) {
            setState(() {
              dateTime = value!;
            });
          });
        },
        child: Text(
          dateTime.toString().substring(0, 10),
          style: TextStyle(color: colors.helperWhiteColor),
        ),
      ),
    );
  }
}
