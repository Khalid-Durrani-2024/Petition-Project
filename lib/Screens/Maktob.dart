import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:petition/Screens/AddUniversities.dart';
import 'package:petition/Screens/AddUser.dart';
import 'package:petition/Screens/Admin.dart';
import 'package:petition/Screens/Faculty.dart';
import 'package:petition/Screens/Login.dart';
import 'package:petition/Screens/SignedPetitions.dart';
import 'package:petition/Screens/Universities.dart';
import 'package:file_picker/file_picker.dart';
import 'package:petition/models/ApiService.dart';
import '../Authentication/AuthData.dart';
import '../Colors/Colors.dart';
import '../models/Petition.dart';

class Maktob extends StatefulWidget {
  int index;
  Maktob({required this.index});
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
        endDrawer: Drawer(
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
                  onPressed: () {},
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
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignedPetitions(),
                      ),
                    );
                  },
                  label: Text('Signed Petitions'),
                ),
              ],
            ),
          ),
        ),
        body: maktobScreen(index: widget.index,),
        floatingActionButton: _SpeedDial());
  }
}

//Sending Petition Button means Floating action button on Petition Screen
class _SpeedDial extends StatefulWidget {
  const _SpeedDial({super.key});

  @override
  State<_SpeedDial> createState() => __SpeedDialState();
}

class __SpeedDialState extends State<_SpeedDial> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.buttonColor,
        overlayColor: colors.hoverColor,
        overlayOpacity: 0.5,
        direction: SpeedDialDirection.left,
        spaceBetweenChildren: 10,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            onTap: () {
              Write(context);
            },
            backgroundColor: colors.buttonColor,
            foregroundColor: colors.helperWhiteColor,
            child: Icon(Icons.create_outlined),
          ),
          SpeedDialChild(
            onTap: () {
              Upload(context);
            },
            backgroundColor: colors.buttonColor,
            foregroundColor: colors.helperWhiteColor,
            child: Icon(Icons.cloud_upload_outlined),
          ),
        ]);
  }
}

//sample of petitions n
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
class maktobScreen extends StatefulWidget {
 int index;
 maktobScreen({
   required this.index
});
  @override
  State<maktobScreen> createState() => _maktobScreenState();
}
late Future _getUniversities;
List<String> universitiesInFaculty = [
  '...',

];
Map User={};
class _maktobScreenState extends State<maktobScreen> {
  late Future _futureData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureData = getDataFromServer();
    _getUniversities=getUniversities();
    parsingData();
    getUserData();

  }

    getUserData()async{

  User=await AuthData().getSharedData();

    }
  getDataFromServer() async {
    if(userName.isNotEmpty&&userName!='' && widget.index==1){

     return await ApiService().fetchDataSpecific('petitions', userName);
    }else {
      print(widget.index);
      return await ApiService().fetchData('petitions');
    }
  }
  getUniversities()async{
    return await ApiService().fetchData('universities');
  }

  Future parsingData()async{
    universitiesInFaculty=['...'];
    try{
      var data=await _getUniversities;
      for(int i=0;i<data.length;i++){
        universitiesInFaculty.add(data[i]['name']);
      }
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: _futureData,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Icon(
              Icons.error_outline_outlined,
              size: 50,
            ),
          );
        } else if (snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.only(top: 50),
            decoration: BoxDecoration(color: colors.backgroundColor),
            width: width,
            height: height,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    //showing maktob from button
                    Sheet(context, index, snapshot.data);
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    color: colors.textFieldColor,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            snapshot.data[index]['sender'],
                            style: TextStyle(
                                fontSize: 18, color: colors.helperWhiteColor),
                          ),
                          Text(snapshot.data[index]['date'],
                              style: TextStyle(
                                  fontSize: 12,
                                  color: colors.helperWhiteColor)),
                        ],
                      ),
                      subtitle: Text(
                        snapshot.data[index]['description'],
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
                          snapshot.data[index]['id'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, color: colors.helperWhiteColor),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: Text('No Data Received'),
          );
        }
      },
    );
  }
}

//Showing Maktob

Sheet(BuildContext context, int no, List snapshot) {
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
                  "نمبر مکتوب: " + snapshot[no]['id'],
                  style:
                      TextStyle(color: colors.helperWhiteColor, fontSize: 20),
                ),
                Text(
                  "تاریخ: " + snapshot[no]['date'],
                  style:
                      TextStyle(color: colors.helperWhiteColor, fontSize: 20),
                ),
                Text(
                  snapshot[no]['sender'] + " :لیږوونکی",
                  style:
                      TextStyle(color: colors.helperWhiteColor, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  snapshot[no]['description'],
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



  String _selectedUniversity = universitiesInFaculty.first;
   String type='مکتوب';
 
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();



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
                          onChanged: (value) {
                            type=value;
                          },
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      FutureBuilder(future: _getUniversities,
                          builder: (context, snapshot) {
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return CircularProgressIndicator();
                            }else if(snapshot.hasError){
                              return Center(child: Icon(Icons.error_outline_outlined),);
                            }else{
                              print(snapshot.data);
                           return  Container(

                                width: MediaQuery.of(context).size.width/4,
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

                                    },
                                ),
                              );

                          }
                          },),
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
                          try {

                          final petition = Petition(
                              type: type,
                              date: dateTime.toString().substring(0,10),
                              title: titleController.text.toString(),
                              sender: User['name'],
                              description: descriptionController.text.toString(),
                              receiver: _selectedUniversity,
                              status: 'seen',
                              tracking: 'tracking');
                          ApiService().sendPetition(petition, 'petitions').whenComplete(() {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('مکتوب ولیږل شو'),
                              showCloseIcon: true,
                            ),
                            );
                          });
                        }catch(e){
                            print(e.toString());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ستونزه ده'),
                          showCloseIcon: true,
                          ),
                          );
                        }
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

//Prompt to get file from user

Upload(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  List<String> universitiesInFaculty = [
    '...',
    'ننګرهار پوهنتون',
    'کنړ پوهنتون',
    'کابل پوهنتون',
    'خوست پوهنتون'
  ];
  String _selectedUniversity = universitiesInFaculty.first;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //File Uploading

                  InkWell(
                    onTap: () async {
                      await _OpenFile();
                    },
                    child: FutureBuilder(
                      future: _OpenFile(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (_fileProperty.length < 2) {
                          return Center(
                            child:
                                Stack(alignment: Alignment.center, children: [
                              Icon(
                                Icons.stop_circle_outlined,
                                color: Colors.red,
                                size: MediaQuery.of(context).size.width / 5,
                              ),
                              Text(
                                'لطفاً مکتوب انتخاب کړۍ',
                                style:
                                    TextStyle(color: colors.helperWhiteColor),
                              )
                            ]),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                _fileTypeShowOnScreen(
                                    _fileProperty[2], context),
                                Column(
                                  children: [
                                    Text(
                                      _fileProperty[0].toString(),
                                      style: TextStyle(
                                          color: colors.helperWhiteColor,
                                          fontSize: 28),
                                    ),
                                    Text(
                                      '${_fileProperty[1]} KB',
                                      style: TextStyle(
                                          color: colors.helperWhiteColor,
                                          fontSize: 28),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  //Reciever
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          borderRadius: BorderRadius.circular(22),
                          decoration: InputDecoration(
                              label: Text(' پوهنتون'),
                              labelStyle:
                                  TextStyle(color: colors.helperWhiteColor),
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
                              return 'د پوهنتون انتخاب کړۍ';
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
                          },
                        ),
                      ),
                      Text(
                        '  :ترلاسه کوونکی اداره',
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
                        if (_formKey.currentState!.validate() &&
                            _fileProperty.length > 1) {
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

//Opening File Function
List _fileProperty = [];

Future _OpenFile() async {
  try {
    _fileProperty = [];
    //Excpetion handling on choosing files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        dialogTitle: 'مکتوب انتخاب کړۍ',
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'docx']);

    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;

      _fileProperty.add(result.files.first.name);
      double _doubleSize = result.files.first.size / 1024;
      int _size = _doubleSize.toInt();
      _fileProperty.add(_size);
      _fileProperty.add(result.files.first.extension);
    } else {
      print('No File choosed');
    }
  } catch (e) {
    print('Exception Occured on Picking Files from device' + e.toString());
  }
}

_fileTypeShowOnScreen(String type, BuildContext context) {
  //file types as a icon on screen
  if (type == 'jpg') {
    return Icon(
      Icons.photo_library_outlined,
      size: MediaQuery.of(context).size.width / 5,
      color: colors.textFieldColor,
    );
  } else if (type == 'pdf') {
    return Icon(
      Icons.picture_as_pdf_outlined,
      size: MediaQuery.of(context).size.width / 5,
      color: colors.textFieldColor,
    );
  } else if (type == 'docx') {
    return Icon(
      Icons.text_snippet_outlined,
      size: MediaQuery.of(context).size.width / 5,
      color: colors.textFieldColor,
    );
  }
}
