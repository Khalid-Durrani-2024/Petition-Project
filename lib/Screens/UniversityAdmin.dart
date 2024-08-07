import 'package:flutter/material.dart';
import '../models/ApiService.dart';
import '../Assets/NetworkImages.dart';
import '../Authentication/AuthData.dart';
import '../Widgets/Drawer.dart';
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
            Text(
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
                        child: Icon(Icons.logout_outlined)),
                    Text(
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: currentUser,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
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
                          style: TextStyle(
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
            )
          ]);
        } else {
          return Center(
            child: Text('معلومات لوډ نشول'),
          );
        }
      },
    );
  }
}
