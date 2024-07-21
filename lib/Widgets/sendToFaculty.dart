import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:petition/models/sendToFacultyModel.dart';
import '../Screens/Maktob.dart';
import '../models/ApiService.dart';

late List Faculties;
List actFaculty = [];
List<String> actFacultyName = ['...'];

getFaculties() async {
  Faculties=[];
  actFaculty=[];
  actFacultyName=['...'];
  Faculties = await ApiService().fetchData('faculty');
  Faculties.forEach((element) {
    if (element['university_id'] == User['id']) {
      actFaculty.add(element);

    }
  });
  actFaculty.forEach((element) {
    actFacultyName.add(element['name']);
  });
  return Faculties;
}

senddToFaculty(BuildContext context,Map snapshot) {
  String? _selectedFaculty = actFacultyName.first;
  TextEditingController CommentController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (index) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 10),
              )
            ]),
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    'ترلاسه کوونکی پوهنځی',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //title

                Row(
                  //Drop Down List Reciever
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: FutureBuilder(
                        future: getFaculties(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Icon(
                                Icons.error_outline_outlined,
                                color: Colors.red,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            print(snapshot.data);
                            return Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    borderRadius: BorderRadius.circular(22),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    dropdownColor: Colors.blue,
                                    isExpanded: true,
                                    hint: Text('انتخاب کړۍ'),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          value == '' ||
                                          value ==
                                              universitiesInFaculty.first) {
                                        return 'پوهنځي نوم انتخاب کړۍ';
                                      }
                                    },
                                    value: actFacultyName[0],
                                    items: actFacultyName.map((String e) {
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (cha) {
                                      _selectedFaculty = cha;
                                    },
                                  ),
                                ),
                                Text(
                                  'پوهنځی',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: Text('معلومات لوډ نشول'),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),

                //title
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'د مکتوب ځواب',
                        ),
                        controller: CommentController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'د مکتوب ځواب ولیکۍ';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'ځواب',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                       final sendfacultymodel=SendToFacultyModel(petition_id: snapshot['id'],faculty_id: actFaculty[0]['id'],comment: CommentController.text);
                            print(sendfacultymodel.petition_id);
                            print(sendfacultymodel.faculty_id);
                            print(sendfacultymodel.comment);
                       // ApiService().sendToFaculty(
                          //     sendfacultymodel, 'received_to_faculty');
                        }catch(e){
                          print('erro occured during sending to faculty${e}');
                        }

                      }
                      ;
                    },
                    child: Text('مکتوب ولیګۍ پوهنځی ته'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 66, 23, 255),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
