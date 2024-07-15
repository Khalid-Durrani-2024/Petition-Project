import 'package:flutter/material.dart';
import 'package:petition/models/ApiService.dart';
import 'package:petition/models/UniversityAdminModel.dart';

import '../Colors/Colors.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colors.buttonColor,
        foregroundColor: colors.helperWhiteColor,
        onPressed: () {
          //adding university admin form
          AddUniversityAdminForm(context);
        },
        label: Text('اډمین اضافه کړۍ'),
      ),
      body: AddUserScreen(),
      appBar: AppBar(
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.textFieldColor,
        title: Text('د پوهنتونونو اډمینان'),
        centerTitle: true,
      ),
    );
  }
}

//adding new user to the system using admin
class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    _getUsers() async {
      return await ApiService().fetchData('users');
    }

    var _currentWidt = MediaQuery.of(context).size.width;
    return Container(
        color: colors.backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
          future: _getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Icon(
                  Icons.error_outline_outlined,
                  color: Colors.red,
                ),
              );
            } else if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      tileColor: colors.textFieldColor,
                      textColor: colors.helperWhiteColor,
                      title: Text(
                        '${snapshot.data[index]['name']} :نوم',
                        style:
                            TextStyle(fontSize: _currentWidt > 500 ? 20 : 36),
                      ),
                      subtitle: Text(
                        '${snapshot.data[index]['email']} :ایمیل ',
                        style:
                            TextStyle(fontSize: _currentWidt > 500 ? 18 : 36),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _currentWidt > 500 ? 4 : 1),
              );
            } else {
              return Center(
                child: Text(
                  'معلومات نشته',
                  style: TextStyle(color: colors.helperWhiteColor),
                ),
              );
            }
          },
        ));
  }
}

//Adding university admin form
AddUniversityAdminForm(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ))
        ],
        backgroundColor: colors.backgroundColor,
        content: _AdminForm(),
      );
    },
  );
}

class _AdminForm extends StatefulWidget {
  const _AdminForm({super.key});

  @override
  State<_AdminForm> createState() => _AdminFormState();
}

class _AdminFormState extends State<_AdminForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> _universities = ['...'];
  List chooseUniversity = [];

  _getUniversities() async {
    List un = await ApiService().fetchData('universities');

    for (int i = 0; i < un.length; i++) {
      _universities.add(un[i]['name']);
      chooseUniversity.add(un[i]);
    }
  }

  String _selectedUniversity = '...';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUniversities();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String _selectedId = '';
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    int universityId = 0;

    //method for getting university admin last number
    _getUniversitiesAdmins() async {
      List universities = await ApiService().fetchData('users');
      for (int i = 0; i < universities.length; i++) {
        _selectedId = universities[i]['id'];
      }
      return _selectedId;
    }

    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //User ID Field
                decoration: BoxDecoration(
                  color: colors.textFieldColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                width: width / 2,
                child: FutureBuilder(
                  future: _getUniversitiesAdmins(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TextFormField(
                        textDirection: TextDirection.rtl,
                        enabled: false,
                        initialValue: snapshot.data.toString(),
                        validator: (value) {},
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22)),
                          labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w100),
                          label: const Text(' مسلسله شمیره'),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Icon(
                          Icons.error_outline_outlined,
                          color: Colors.red,
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          'معلومات پیدا نشول',
                          style: TextStyle(color: colors.helperWhiteColor),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(
                  controller: nameController,
                  textDirection: TextDirection.rtl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'د استعمالوونکي پوره نوم ولیکۍ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                      label: const Text('نوم')),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(
                  controller: emailController,
                  textDirection: TextDirection.rtl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'د استعمالوونکۍ ایمیل ادرس ولیکۍ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                      label: const Text('ایمیل')),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: TextFormField(
                  controller: passwordController,
                  textDirection: TextDirection.rtl,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'د استعمالوونکي لپاره پټ نوم انتخاب کړۍ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w100),
                      label: const Text('پټ نوم')),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colors.textFieldColor,
                    borderRadius: BorderRadius.circular(22)),
                width: width / 2,
                child: FutureBuilder(
                  future: _getUniversitiesAdmins(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Icon(Icons.error_outline_outlined),
                      );
                    } else {
                      print(snapshot.data);
                      return Container(
                        width: MediaQuery.of(context).size.width / 4,
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
                                value == _universities.first) {
                              return 'د پوهنتون نوم انتخاب کړۍ';
                            }
                          },
                          value: _selectedUniversity,
                          items: _universities.map((String e) {
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
                            chooseUniversity.forEach((element) {
                              if (element['name'] == _selectedUniversity) {
                                universityId = int.parse(element['id']);
                              }
                            });
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              InkWell(
                onTap: () async{
                  if (_formKey.currentState!.validate()) {
                    final model = UniversityAdminModel(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        university_id: universityId,
                        created_at: DateTime.now().toString().substring(0, 10),
                        role: 'university');

                  int response=await  ApiService().sendUAdmin(model, 'users');
                    if(response==201){
                      Navigator.pop(context);
                      showMessage(true, context);
                    }else {
                      showMessage(false, context);
                    }
                    }
                },
                //Save Button
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: colors.buttonColor),
                  width: width / 5,
                  height: height / 15,
                  child: const Text(
                    'ثبت کړۍ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

//Message Showing Success and not success

showMessage(bool isSuccess, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        backgroundColor: colors.backgroundColor,
        actions: [
          InkWell(
            child: Icon(
              Icons.close_outlined,
              color: colors.helperWhiteColor,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Icon(
          isSuccess == true ? Icons.check : Icons.dangerous_outlined,
          color: isSuccess == true ? Colors.green : Colors.red,
          size: 60,
        ),
        content: isSuccess == true
            ? Text('نوی استعمالوونکی سیستم ته اضافه شو')
            : Text('ستونزه رامنځته شوه'),
        contentTextStyle: TextStyle(color: colors.helperWhiteColor),
      );
    },
  );
}
