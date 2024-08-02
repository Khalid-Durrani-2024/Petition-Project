import 'package:flutter/material.dart';
import '../Widgets/Message.dart';
import '../models/sendFromFacultyModel.dart';
import '../Screens/Maktob.dart';
import '../models/ApiService.dart';

List<String> actUniversityName = ['...', User['university_name']];

senddToUniversity(BuildContext context, Map snapshot) {
  TextEditingController CommentController = TextEditingController();
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
                    'پوهنتون ته ولیږۍ',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //title
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        borderRadius: BorderRadius.circular(22),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        dropdownColor: Colors.blue,
                        isExpanded: true,
                        hint: Text('انتخاب کړۍ'),
                        validator: (value) {
                          if (value!.isEmpty ||
                              value == '' ||
                              value == universitiesInFaculty.first) {
                            return 'پوهنتون نوم انتخاب کړۍ';
                          }
                        },
                        value: actUniversityName[0],
                        items: actUniversityName.map((String e) {
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
                        onChanged: (cha) {},
                      ),
                    ),
                    Text(
                      'پوهنتون',
                      style: TextStyle(color: Colors.black),
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final sfmodel = SendFromFacultyModel(
                            petition_id: snapshot['id'].toString(),
                            university_id: User['university_id'].toString(),
                            comment: CommentController.text,
                            faculty_id: User['id'].toString());

                        int res = await ApiService()
                            .sendFromFaculty(sfmodel, 'send_from_faculty')
                            .whenComplete(() => Navigator.pop(context));
                        if(res==201){
                          Message(true, context,'پوهنتون ته مکتوب بیرته ولیږل شو');
                        }else{

                          Message(false, context,'ستونزه ده');
                        }
                      }
                    },
                    child: Text('مکتوب ولیګۍ پوهنتون ته'),
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
