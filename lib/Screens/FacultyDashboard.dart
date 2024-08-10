import 'package:flutter/material.dart';
import 'package:petition/Widgets/Drawer.dart';

import '../Assets/NetworkImages.dart';
import '../Authentication/AuthData.dart';
import '../models/ApiService.dart';
import 'Login.dart';
import 'Maktob.dart';
import 'Setting.dart';

class FacultyDashboard extends StatefulWidget {
  const FacultyDashboard({super.key});

  @override
  State<FacultyDashboard> createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {
  late Future _currentUser;
  _getUser() async {
    return await AuthData().getSharedData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentUser = _getUser();
  }

  List _facultyList = ['پوهنځی ته راغلي مکتوبونه', 'سیټینګ', 'معلومات', 'وتل'];
  List<Icon> _facultyIcons = const [
    Icon(Icons.storage_outlined, size: 50),
    Icon(Icons.settings_outlined, size: 50),
    Icon(Icons.info_outline, size: 50),
    Icon(Icons.logout_outlined, size: 50),
  ];
  void _showAbout(BuildContext context) {
    showAboutDialog(context: context);
  }

  void _logout(BuildContext context) {
    AuthData().deleteShared();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: DrawerForFaculty(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 31, 253),
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'د اسنادو د لیږد را لیږد مدیریتی سیستم',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                        child: const Icon(Icons.logout_outlined)),
                    const Text(
                      'وتل',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _currentUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Icon(
                Icons.error_outline_outlined,
                color: Colors.red,
              ),
            );
          } else if (snapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: _currentUser,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            } else if (snapshot.hasData) {
                              return Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(ministryImage),
                                    radius: 100,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'پوهنتون',
                                        style: const TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.933),
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'CustomFont',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          ' - ',
                                          style: const TextStyle(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.933),
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CustomFont',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data['university_name']
                                            .toString(),
                                        style: const TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.933),
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'CustomFont',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'پوهنځی',
                                        style: const TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.933),
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'CustomFont',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          ' - ',
                                          style: const TextStyle(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.933),
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'CustomFont',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data['name'].toString(),
                                        style: const TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.933),
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'CustomFont',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                              );
                            } else {
                              return Center(
                                child: Text('مشکل رامنځ ته شو'),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _facultyList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 22),
                        child: GestureDetector(
                          onTap: () {
                            if (index == 0) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Maktob(index: 10),
                              ));
                            } else if (index == 1) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Setting(),
                              ));
                            } else if (index == 2) {
                              _showAbout(context);
                            } else if (index == 3) {
                              _logout(context);
                            }
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
                              color: Color.fromARGB(255, 48, 145, 235),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: width / 6.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _facultyIcons[index],
                                const SizedBox(height: 10),
                                Text(
                                  _facultyList[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
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
            );
          } else {
            return Center(
              child: Text('مشکل رامنځ ته شو'),
            );
          }
        },
      ),
    );
  }
}
