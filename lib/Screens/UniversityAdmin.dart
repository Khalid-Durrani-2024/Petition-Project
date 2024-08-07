import 'package:flutter/material.dart';
import '../Screens/Setting.dart';
import '../Screens/SignedFromUniversity.dart';
import '../models/ApiService.dart';
import '../Assets/NetworkImages.dart';
import '../Authentication/AuthData.dart';
import '../Widgets/Drawer.dart';
import 'Faculty.dart';
import 'Login.dart';
import 'Maktob.dart';

class Universityadmin extends StatefulWidget {
  const Universityadmin({super.key});

  @override
  State<Universityadmin> createState() => _UniversityadminState();
}

late Future currentUser;

class _UniversityadminState extends State<Universityadmin> {
  getUserData() async {
    User = await AuthData().getSharedData();
    List response = await ApiService().fetchData('universities');
    Map uni = {};
    response.forEach(
      (element) {
        if (element['id'] == User['university_id']) {
          uni = element;
        }
      },
    );
    return uni;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerForUniversity(),
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
      body: UniversityDashboard(),
    );
  }
}

class UniversityDashboard extends StatefulWidget {
  const UniversityDashboard({super.key});

  @override
  State<UniversityDashboard> createState() => _UniversityDashboardState();
}

class _UniversityDashboardState extends State<UniversityDashboard> {
  universitiesPics(String name) {
    List _universitiesPics = ['helman', 'hewad', 'kabul', 'paktia', 'shaikh'];
    if (_universitiesPics.contains(name)) {
      return 'lib/Assets/${name}.jpeg';
    } else {
      return false;
    }
  }

  List universityList = [
    'ټــــــول مکتوبونه',
    'امضاء شوي مکتوبونه',
    'پوهنځی اضافه کړۍ',
    'سیټینګ',
  ];
  List<Icon> adminIcons = const [
    Icon(Icons.storage_outlined, size: 50),
    Icon(Icons.done_all_outlined, size: 50),
    Icon(Icons.account_circle_outlined, size: 50),
    Icon(Icons.settings_outlined, size: 50),
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: currentUser,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
          );
        } else if (snapshot.hasData) {
          print(snapshot.data);
          return Column(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: currentUser,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          return universitiesPics(snapshot.data['name']) ==
                                  false
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(ministryImage),
                                  radius: 100,
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  // width: MediaQuery.of(context).size.width / 6,
                                  width: 220,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      universitiesPics(snapshot.data['name']),
                                    ),
                                  ),
                                );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: currentUser,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data['name'].toString(),
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.933),
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'CustomFont',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: universityList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 22),
                      child: GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Maktob(index: 9),
                            ));
                          } else if (index == 1) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignedFromUniversity(),
                            ));
                          } else if (index == 2) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Faculty(),
                            ));
                          } else if (index == 3) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Setting(),
                            ));
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
                              adminIcons[index],
                              const SizedBox(height: 10),
                              Text(
                                universityList[index],
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
                ))
          ]);
        } else {
          return const Center(
            child: Text('معلومات لوډ نشول'),
          );
        }
      },
    );
  }
}
