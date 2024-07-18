import 'package:flutter/material.dart';
import '../Colors/Colors.dart';
import '../models/ApiService.dart';
import '../models/Faculty.dart';
import 'Maktob.dart';

class Faculty extends StatefulWidget {
  const Faculty({super.key});

  @override
  State<Faculty> createState() => _FacultyState();
}

class _FacultyState extends State<Faculty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FacultyScreen(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 31, 253),
        foregroundColor: colors.helperWhiteColor,
        centerTitle: true,
        title: Text('د اسنادو مدیریت عصری کول'),
        leading: BackButton(),
      ),
    );
  }
}

//Add Faculty

class FacultyScreen extends StatefulWidget {
  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

List universitiesMap = [];
int _selectedId = 0;
TextEditingController _noFaculty = TextEditingController();
int _selectedFaculty = 0;

getFaculties() async {
  try {
    var data = await ApiService().fetchData('faculty');
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        _selectedFaculty = int.parse(data[i]['id']);
      }
      print(_selectedFaculty);
      _noFaculty.text = _selectedFaculty.toString();
    } else {
      print('No Data Found');
    }
  } catch (e) {
    print(e.toString());
  }
}

bool hoverChange = false;
String _selectedUniversity = '';

class _FacultyScreenState extends State<FacultyScreen> {
  Future<void> getUniversities() async {
    List data = await ApiService().fetchData('universities');
    data.forEach((element) {
      if (element['id'] == User['id']) {
        _selectedUniversity = element['name'];
        _selectedId = int.parse(element['id']);
      }
    });
    return await ApiService().fetchData('universities');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUniversities();
    getFaculties();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController facultyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: getUniversities(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: double.infinity,
            height: height,
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(30),
                        //Faculty ID Field
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        width: width * 0.8,
                        constraints: BoxConstraints(maxWidth: 800),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'مهرباني وکړۍ پوهنځی اضافه کړۍ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              textDirection: TextDirection.rtl,
                              controller: _noFaculty,
                              readOnly: true,
                              validator: (value) {},
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w100),
                                  label: _noFaculty.text != ''
                                      ? Text('د پوهنځي مسلسله شمیره')
                                      : Icon(
                                          Icons.error_outline,
                                          color: Colors.black,
                                        )),
                            ),
                            //Faculty Name
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              textDirection: TextDirection.rtl,
                              controller: facultyController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'د پوهنځي نوم دننه کړۍ';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  label: Text('پوهنځي نوم')),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //University Selection
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: ' پوهنتون',
                                labelStyle:
                                    TextStyle(color: Colors.black, fontSize: 14),
                                border: OutlineInputBorder(),
                              ),
                              hint: Text('انتخاب کړۍ'),
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    _selectedUniversity,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                              onChanged: (Object? value) {},
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
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

                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  labelText: 'ایمیل'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //Password Section
                            TextFormField(
                              textDirection: TextDirection.rtl,
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'پټ نوم دننه کړۍ';
                                }
                                return null;
                              },
                              obscureText: true,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  label: Text('پټ نوم')),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                                onHover: (value) {
                                  setState(() {
                                    hoverChange = value;
                                  });
                                },
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final faculty = FacultyModel(
                                        name: facultyController.text,
                                        university_id: _selectedId,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        university_name: _selectedUniversity,
                                        role: 'Faculty');
                                    print(faculty.name);
                                    print(faculty.university_id);
                                    print(faculty.email);
                                    print(faculty.password);
                                    print(faculty.university_name);
                                    print(faculty.role);
                  
                                    int res = await ApiService()
                                        .sendFaculty(faculty, 'faculty');
                  
                                    if (res == 201) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('پوهنځی اضافه شو'),
                                          showCloseIcon: true,
                                        ),
                                      );
                                      Navigator.pop(context);
                                      facultyController.text = '';
                                      emailController.text = '';
                                      passwordController.text = '';
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('ستونزه ده'),
                                          showCloseIcon: true,
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                                //Log In Button
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width * 0.2,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                    color: hoverChange
                                        ? Colors.blue.shade700
                                        : Colors.blue,
                                    borderRadius: BorderRadius.circular(22),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'ثبت کړۍ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'بهر شاته',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('!!! معلومات نشته'),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
