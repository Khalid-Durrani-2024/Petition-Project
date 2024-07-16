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
        backgroundColor: colors.textFieldColor,
        foregroundColor: colors.helperWhiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
            )
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
                colors: [colors.backgroundColor, colors.textFieldColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(ministryImage),
                            radius: 80,
                          ),
                          SizedBox(height: 10),
                          Text(
                            userName,
                            style: TextStyle(
                              color: colors.helperWhiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userEmail,
                            style: TextStyle(
                              color: colors.helperWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            userType,
                            style: TextStyle(
                              color: colors.helperWhiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: adminList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
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
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: colors.buttonColor.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(3, 3),
                                )
                              ],
                              color: colors.textFieldColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                adminIcons[index],
                                SizedBox(height: 10),
                                Text(
                                  adminList[index],
                                  style: TextStyle(
                                    color: colors.helperWhiteColor,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
