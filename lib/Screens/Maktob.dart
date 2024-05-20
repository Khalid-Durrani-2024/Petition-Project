import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Colors/Colors.dart';

class Maktob extends StatelessWidget {
  const Maktob({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.textFieldColor,
      ),
      drawer: Drawer(),
      body: maktobScreen(),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.buttonColor,
        onPressed: () {
          Write(context);
        },
        label: Text('مکتوب ولیګۍ'),
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
  final _formKey = GlobalKey<FormState>();
  return showModalBottomSheet(
      context: context,
      builder: (index) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      controller: noController,
                      validator: (validator) {},
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
