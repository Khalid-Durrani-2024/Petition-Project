import 'package:flutter/material.dart';
import 'package:petition/Screens/Admin.dart';
import 'package:petition/models/ApiService.dart';
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

Map currentUser = {};

class _UniversityadminState extends State<Universityadmin> {
  getUserData() async {
    User = await AuthData().getSharedData();
    List response = await ApiService().fetchData('universities');
    response.forEach(
      (element) {
        if (element['id'] == User['university_id']) {
          currentUser = element;
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
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
  getUserData() async {
    return await AuthData().getSharedData();
  }

  const UniversityDashboard({super.key});

  @override
  State<UniversityDashboard> createState() => _UniversityDashboardState();
}

class _UniversityDashboardState extends State<UniversityDashboard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
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
                    CircleAvatar(
                      backgroundImage: NetworkImage(ministryImage),
                      radius: 100,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentUser['name'],
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.933),
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CustomFont',
                      ),
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
