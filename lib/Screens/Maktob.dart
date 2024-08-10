import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../Screens/FacultyDashboard.dart';
import '../Assets/NetworkImages.dart';
import '../Screens/Admin.dart';
import 'package:file_picker/file_picker.dart';
import '../Widgets/SignPetition.dart';
import '../Widgets/sendToFaculty.dart';
import '../Widgets/sendToUniversity.dart';
import '../models/ApiService.dart';
import '../Authentication/AuthData.dart';
import '../Colors/Colors.dart';
import '../Widgets/Drawer.dart';
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
          leading: User['role'] == 'admin'
              ? BackButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Admin(),
                    ));
                  },
                )
              : User['role'] == 'Faculty'
                  ? BackButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => FacultyDashboard(),
                        ));
                      },
                    )
                  : SizedBox(),
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 15, 31, 253),
          title: Text('د اسنادو د لیږد رالیږد مدیریتی سسیتم'),
          centerTitle: true,
        ),
        endDrawer: FutureBuilder(
          future: AuthData().getSharedData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('معلومات لاوډ نه شول');
            } else if (snapshot.hasData) {
              return Drawer(
                backgroundColor: colors.backgroundColor,
                child: userType == 'admin'
                    ? DesignedDrawer()
                    : userType == 'university'
                        ? DrawerForUniversity()
                        : userType == 'Faculty'
                            ? DrawerForFaculty()
                            : Container(),
              );
            } else {
              return Container();
            }
          },
        ),
        body: maktobScreen(
          index: widget.index,
        ),
        floatingActionButton: userType == 'admin'
            ? _SpeedDial()
            : userType == 'university'
                ? Container()
                : userType == 'Faculty'
                    ? Container()
                    : Icon(Icons.error_outline_outlined));
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
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
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
            backgroundColor: Colors.black,
            foregroundColor: colors.helperWhiteColor,
            child: Icon(Icons.create_outlined),
          ),
          SpeedDialChild(
            onTap: () {
              Upload(context);
            },
            backgroundColor: Colors.black,
            foregroundColor: colors.helperWhiteColor,
            child: Icon(Icons.cloud_upload_outlined),
          ),
        ]);
  }
}

//maktob screen
class maktobScreen extends StatefulWidget {
  int index;

  maktobScreen({required this.index});

  @override
  State<maktobScreen> createState() => _maktobScreenState();
}

late Future _getUniversities;
List<String> universitiesInFaculty = [
  '...',
];
Map User = {};

class _maktobScreenState extends State<maktobScreen> {
  late Future _futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(userType);
    _futureData = getDataFromServer();
    _getUniversities = getUniversities();
    parsingData();
    getUserData();
  }

  getUserData() async {
    User = await AuthData().getSharedData();
    userName = User['name'];
    userEmail = User['email'];
    userType = User['role'];
  }

  getDataFromServer() async {
    if (userName.isNotEmpty && userName != '' && widget.index == 1) {
      print('For admin');
      return await ApiService().fetchDataSpecific('petitions', userName);
    } else {
      if (widget.index == 10) {
        print('For Faculty');
        List data = await ApiService().fetchData('received_to_faculties');
        List petitionsData = await ApiService().fetchData('petitions');
        List NaturalData = [];
        data.forEach((elementUp) {
          if (elementUp['faculty_id'] == User['id']) {
            petitionsData.forEach((element) {
              if (element['id'] == elementUp['petition_id']) {
                NaturalData.add(element);
              }
            });
          }
        });
        return NaturalData;
      } else if (widget.index == 9) {
        print('For University');
        List data = await ApiService().fetchData('petitions');
        List _universities = await ApiService().fetchData('universities');
        String receiver = 'ټول';
        _universities.forEach((element) {
          if (User['university_id'] == element['id']) {
            receiver = element['name'];
          }
        });

        List NaturalData = [];

        print(receiver);
        data.forEach((element) {
          if (element['receiver'] == receiver) {
            NaturalData.add(element);
          }
        });
        return NaturalData;
      } else {
        return await ApiService().fetchData('petitions');
      }
    }
  }

  getUniversities() async {
    return await ApiService().fetchData('universities');
  }

  Future parsingData() async {
    universitiesInFaculty = ['...', 'ټول پوهنتونونه'];
    try {
      var data = await _getUniversities;
      for (int i = 0; i < data.length; i++) {
        universitiesInFaculty.add(data[i]['name']);
      }
    } catch (e) {
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
            color: Color.fromARGB(255, 230, 220, 220),
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
                    color: Color.fromARGB(255, 41, 135, 230),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            snapshot.data[index]['sender'],
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data[index]['title'],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(snapshot.data[index]['date'],
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ],
                      ),
                      subtitle: Text(
                        snapshot.data[index]['receiver'],
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 33, 7, 181),
                            shape: BoxShape.circle),
                        width: width / 15,
                        height: height / 15,
                        child: Text(
                          snapshot.data[index]['id'].toString(),
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
            child: Text('معلومات نشته'),
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
        backgroundColor: Color.fromARGB(255, 249, 230, 230),
        content: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  child: Icon(Icons.arrow_forward_ios_rounded),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('lib/Assets/ulogo.jpg'),
                      ),
                    ),
                    Column(
                      children: [
                        Text('بسم الله الرحمن الرحیم'),
                        Text(
                          'د افغانستان اسلامي امارت',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'د لوړو زده کړو وزارت',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'سید جمال الدین افغاني پوهنتون',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'محصلانو چارو معاونیت',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'محصلانو چارو آمریت',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'اجرائېه ماموریت',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(ministryImage),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Row For Type of Maktob
                    Row(
                      children: [
                        Column(
                          children: [
                            Text('غیر محرم'),
                            Checkbox(
                                value: snapshot[no]['type'] == 'غیر محرم'
                                    ? true
                                    : false,
                                onChanged: (val) {}),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text('محرم'),
                            Checkbox(
                                value: snapshot[no]['type'] == 'محرم'
                                    ? true
                                    : false,
                                onChanged: (val) {}),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text('عادي'),
                            Checkbox(
                                value: snapshot[no]['type'] == 'عادي'
                                    ? true
                                    : false,
                                onChanged: (val) {}),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text('جدی'),
                            Checkbox(
                                value: snapshot[no]['type'] == 'جدي'
                                    ? true
                                    : false,
                                onChanged: (val) {}),
                          ],
                        ),
                      ],
                    ),
                    //Row For Gana and Date
                    Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  snapshot[no]['id'].toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(' :ګڼه'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  snapshot[no]['date'].toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(' :نیټه'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Text(': د ازموینو ملی اداری محترم مقام'),
                Text('! د ازموینو د سمون محترم ریاست د پام وړ'),
                Text('! السلام علیکم ورحمت الله وبرکاته'),
                Text(
                  'موضوع: ${snapshot[no]['title']} ',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  snapshot[no]['description'],
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                userType == 'university'
                    ? Center(
                        child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              SignPetition(context, snapshot[no], User);
                            },
                            icon: Icon(
                              Icons.create_outlined,
                              color: Colors.blue,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              senddToFaculty(context, snapshot[no]);
                            },
                            child: Text('پوهنځی ته ولیږۍ'),
                          ),
                        ],
                      ))
                    : userType == 'Faculty'
                        ? Center(
                            child: TextButton(
                            onPressed: () {
                              senddToUniversity(context, snapshot[no]);
                            },
                            child: Text('پوهنتون ته ولیږۍ'),
                          ))
                        : Container(),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('کوټی سنګي ،کابل، افغانستان'),
                              Icon(Icons.location_on_outlined)
                            ],
                          ),
                          Row(
                            children: [
                              Text('Wezarat@gmail.com'),
                              Icon(Icons.email_outlined),
                            ],
                          ),
                          Row(
                            children: [
                              Text('+9378787887'),
                              Icon(Icons.phone_enabled_outlined)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
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
  DateTime dt = DateTime.now();
  TextEditingController dateController =
      TextEditingController(text: '${dt.year}-${dt.month}-${dt.day}');
  List<String> MaktobTypes = ['...', 'جدي', 'عادي', 'محرم', 'غیر محرم'];
  String _selectedUniversity = universitiesInFaculty.first;
  String type = MaktobTypes.first;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
                    'د مکتوب فورم',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  //Drop Down List
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          label: Align(
                            alignment: Alignment.topRight,
                            child: Text('مکتوب نوعه '),
                          ),
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
                              value == MaktobTypes.first) {
                            return 'د مکتوب نوعه انتخاب کړۍ';
                          }
                        },
                        value: type,
                        items: MaktobTypes.map((String e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                e,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (cha) {
                          type = cha!;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'د مکتوب نوعه',
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  //DateTime
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        enabled: false,
                        initialValue: dateController.text.toString(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          label: Align(
                            alignment: Alignment.topRight,
                            child: Text('تاریخ انتخاب کړۍ'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'تاریخ',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
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
                          label: Align(
                            alignment: Alignment.topRight,
                            child: Text('د مکتوب عنوان'),
                          ),
                        ),
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'د مکتوب عنوان ولیکۍ';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'عنوان',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //Description
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 5,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            label: Align(
                              child: Text('د مکتوب تشریح'),
                              alignment: Alignment.topRight,
                            )),
                        controller: descriptionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "د مکتوب تشریح ولیکۍ";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'ډیسکریبشن',
                        style: TextStyle(color: Colors.black),
                      ),
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
                    Expanded(
                      child: FutureBuilder(
                        future: _getUniversities,
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
                                        return 'د پوهنتون نوم انتخاب کړۍ';
                                      }
                                    },
                                    value: _selectedUniversity,
                                    items:
                                        universitiesInFaculty.map((String e) {
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
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
                                  'د مکتوب ترلاسه کوونکی اداره',
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
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final petition = Petition(
                              type: type,
                              date: dateController.text.toString(),
                              title: titleController.text.toString(),
                              sender: User['name'],
                              description:
                                  descriptionController.text.toString(),
                              receiver: _selectedUniversity,
                              status: 'seen',
                              tracking: 'tracking');
                          ApiService()
                              .sendPetition(petition, 'petitions')
                              .whenComplete(() {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('مکتوب ولیږل شو'),
                                showCloseIcon: true,
                              ),
                            );
                          });
                        } catch (e) {
                          print(e.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('ستونزه ده'),
                              showCloseIcon: true,
                            ),
                          );
                        }
                      }
                    },
                    child: Text('مکتوب ولیګۍ'),
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

//Prompt to get file from user

Upload(BuildContext context) async {
  final _formKey = GlobalKey<FormState>();
  List<String> universitiesInFaculty = [
    '...',
  ];
  List res = await ApiService().fetchData('universities');
  res.forEach((element) {
    universitiesInFaculty.add(element['name']);
  });
  String _selectedUniversity = universitiesInFaculty.first;

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (index) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            dropdownColor: Colors.blue,
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
                                    color: Colors.black,
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
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
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
