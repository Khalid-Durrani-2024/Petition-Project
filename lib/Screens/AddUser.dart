import 'package:flutter/material.dart';
import '../Screens/Faculty.dart';
import '../models/ApiService.dart';
import '../models/UniversityAdminModel.dart';
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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddUserToUniversity(),
          ));
        },
        label: Text('اډمین اضافه کړۍ'),
      ),
      body: AddUserScreen(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 15, 31, 253),
        centerTitle: true,
        title: Text('د اسنادو د لیږد را لیږد مدیریتی سیستم', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
        color: Color.fromARGB(255, 223, 217, 215),
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
                        ),
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

class AddUserToUniversity extends StatefulWidget {
  const AddUserToUniversity({super.key});

  @override
  State<AddUserToUniversity> createState() => _AddUserToUniversityState();
}

class _AddUserToUniversityState extends State<AddUserToUniversity> {
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
    String universityId = '';

    //method for getting university admin last number
   Future _getUniversitiesAdmins() async {
      List universities = await ApiService().fetchData('users');
      for (int i = 0; i < universities.length; i++) {
        _selectedId = universities[i]['id'].toString();
      }
      return _selectedId;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 15, 31, 253),
          centerTitle: true,
          title: Text('د اسنادو مدیریت عصری کول'),
          leading: BackButton(),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: height,
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.grey),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        )
                      ]),
                  width: width * 0.8,
                  constraints: BoxConstraints(maxWidth: 800),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'مهرباني وکړۍ پوهنتون اډمین اضافه کړۍ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder(
                        future: _getUniversitiesAdmins(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                              print(snapshot.error);
                            return Center(
                              child: Icon(Icons.error_outline_outlined),
                            );
                          } else if (snapshot.hasData) {
                            return TextFormField(
                              textDirection: TextDirection.ltr,
                              enabled: false,
                              initialValue: snapshot.data.toString(),
                              validator: (value) {},
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                ),
                                labelText: ' مسلسله شمیره',
                                prefixIcon: const Icon(Icons.confirmation_number_outlined),
                              ),
                            );
                          } else {
                            return Center(
                              child: Text('معلومات لوډ نشول'),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nameController,
                        textDirection: TextDirection.rtl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'د استعمالوونکي پوره نوم ولیکۍ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          ),
                          labelText: 'نوم',
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        textDirection: TextDirection.rtl,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'د استعمالوونکۍ ایمیل ادرس ولیکۍ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          ),
                          labelText: 'ایمیل',
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
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
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          ),
                          labelText: 'پټ نوم',
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder(
                        future: _getUniversitiesAdmins(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Icon(Icons.error_outline_outlined),
                            );
                          } else {
                            print(snapshot.data);
                            return DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: ' پوهنتون',
                                prefixIcon: const Icon(Icons.school_outlined),
                                border: OutlineInputBorder(),
                              ),
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
                                  ),
                                );
                              }).toList(),
                              onChanged: (cha) {
                                _selectedUniversity = cha!;
                                chooseUniversity.forEach((element) {
                                   print(element);
                                   print(_selectedUniversity);
                                  if (element['name'] == _selectedUniversity) {
                                    universityId = element['id'].toString();
                                  }
                                });
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final model = UniversityAdminModel(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                university_id: universityId,
                                created_at:
                                    DateTime.now().toString().substring(0, 10),
                                role: 'university');
                
                            int response =
                                await ApiService().sendUAdmin(model, 'users');
                            
                            if (response == 201) {
                              Navigator.pop(context);
                              showMessage(true, context);
                            } else {
                              print(model.name);
                               print(model.email); 
                               print(model.password);
                               print(model.university_id);
                               print(model.created_at);
                              showMessage(false, context);
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: hoverChange
                                  ? Colors.blue.shade700
                                  : Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                )
                              ]),
                          width: width * 0.2,
                          height: height * 0.07,
                          child: const Text(
                            'ثبت کړۍ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'بهر شۍ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.blue),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
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
