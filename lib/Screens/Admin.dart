import 'package:flutter/material.dart';
import 'package:petition/Authentication/AuthData.dart';
import 'package:petition/Screens/AddUser.dart';
import 'package:petition/Screens/Login.dart';
import 'package:petition/Screens/Maktob.dart';
import 'package:petition/Screens/Setting.dart';
import 'package:petition/Screens/SignedPetitions.dart';
import 'package:petition/Screens/Universities.dart';
import '../Assets/NetworkImages.dart';
import '../Colors/Colors.dart';
import '../Widgets/Drawer.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

getUserData() async {
  try {
    return await AuthData().getSharedData();
  } catch (e) {
    print('error on getting user data from shared Preferences${e.toString()}');
  }
}

class _AdminState extends State<Admin> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15,31, 253),
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                Text('د اسنادو د مدیریت عصری کول',textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
            Row(
              children: [
                Column(

                  children: [
                    InkWell(child: Icon(Icons.notifications_none_outlined)),
                    Text(
                      'خبرداری',
                      style: TextStyle(fontSize: 10),
                    )

                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            AuthData().deleteShared();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                          });
                        },
                        child: Icon(Icons.logout_outlined)),
                    Text(
                      'وتل',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),

              ],
            ),

          ],
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: colors.backgroundColor,
        child: DesignedDrawer(),
      ),
      body: AdminScreen(),
    );
  }
}

//Admin Screen
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

String userName = '';
String userEmail = '';
String userType = '';

class _AdminScreenState extends State<AdminScreen> {
  List adminList = [
    'ټــــــول مکتوبونه',
    'لیږل شوي مکتوبونه',
    'امضاء شوي مکتوبونه',
    'پوهنتونونه',
    'سیټینګ',
    'د پوهنتونونو اډمینان'
  ];
  List<Icon> adminIcons = const [
    Icon(Icons.storage_outlined, size: 50),
    Icon(Icons.call_made_outlined, size: 50),
    Icon(Icons.done_all_outlined, size: 50),
    Icon(Icons.school_outlined, size: 50),
    Icon(Icons.settings_outlined, size: 50),
    Icon(Icons.person_add_outlined, size: 50),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Icon(Icons.error_outline_outlined));
        } else if (snapshot.hasData) {
          Map data = snapshot.data as Map;
          userName = data['name'];
          userEmail = data['email'];
          userType = data['role'];
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 223, 217, 215),
                Color.fromARGB(252, 215, 246, 239)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(ministryImage),
                          radius: 100,
                        ),
                       const SizedBox(height: 10),
                        Text('د سید جمالدین افغاني پوهنتون',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0,
                                0, 0.933),
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'CustomFont',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const  SizedBox(height: 10,),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                    itemCount: adminList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 22),
                        child: GestureDetector(
                          onTap: () {
                            index == 0
                                ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Maktob(index: 0);
                                },
                              ),
                            )
                                : index == 1
                                ? Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => Maktob(index: 1),
                              ),
                            )
                                : index == 2
                                ? Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SignedPetitions(),
                              ),
                            )
                                : index == 3
                                ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Universities()))
                                : index == 5
                                ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddUser(),
                              ),
                            )
                                : Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Setting(),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(3, 3),
                                )
                              ],
                              color: Color.fromARGB(255,
                                  48, 145, 235),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: width/6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                adminIcons[index],
                              const  SizedBox(height: 10),
                                Text(
                                  adminList[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text('ډیټا لوډ نشول ډیټابیس کنیکشن چک کړۍ'));
        }
      },
    );
  }
}
