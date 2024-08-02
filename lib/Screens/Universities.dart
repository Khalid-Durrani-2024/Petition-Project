import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../Screens/AddUniversities.dart';
import '../Screens/AddUser.dart';
import '../Screens/UpdateUniversities.dart';
import '../Widgets/Drawer.dart';
import '../models/ApiService.dart';

import '../Colors/Colors.dart';

class Universities extends StatefulWidget {
  const Universities({super.key});

  @override
  State<Universities> createState() => _UniversitiesState();
}

class _UniversitiesState extends State<Universities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: BackButton(),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 15, 31, 253),

        title: Text('د اسنادو د لیږد رالیږد مدیریتی سسیتم', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      endDrawer: Drawer(
        child: DesignedDrawer(),
      ),
      body: UniversitiesScreen(),
      floatingActionButton: _SpeedDial(),
    );
  }
}

// Actual screen
class UniversitiesScreen extends StatefulWidget {
  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

_getUniversities() async {
  return await ApiService().fetchData('universities');
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  late Future _future;

  @override
  void initState() {
    super.initState();
    _future = _getUniversities();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 223, 217, 215),
            Color.fromARGB(252, 215, 246, 239)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.all(20),
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Icon(
                Icons.error_outline_outlined,
                color: colors.helperWhiteColor,
              ),
            );
          } else if (snapshot.hasData) {
            return Scrollbar(
              child: GridView.builder(
                physics: BouncingScrollPhysics(

                ),
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: currentWidth > 300 ? 3 : 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      UpdateUniversity(context, snapshot.data[index]);
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(
                              255, 167, 229, 255), // Adjust to your light color theme
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              snapshot.data[index]['name'],
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color:
                                Colors.black, // Adjust to your light color theme
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Icon(
                                  Icons.school_outlined,
                                  color: Colors.black,
                                  size: 120,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text('معلومات پیدا نشول'),
            );
          }
        },
      ),
    );
  }
}


// Speed Dial On adding University and User to a Specific University
class _SpeedDial extends StatefulWidget {
  const _SpeedDial({super.key});

  @override
  State<_SpeedDial> createState() => _SpeedDialState();
}

class _SpeedDialState extends State<_SpeedDial> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      foregroundColor: colors.helperWhiteColor,
      backgroundColor: colors.buttonColor,
      overlayColor: colors.hoverColor,
      overlayOpacity: 0.5,
      spaceBetweenChildren: 10,
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
          child: Icon(Icons.school_outlined),
          label: 'پوهنتون اضافه کړۍ',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddUniversity(),
              ),
            );
          },
          backgroundColor: colors.buttonColor,
          foregroundColor: colors.helperWhiteColor,
        ),
        SpeedDialChild(
          label: 'پوهنتون اډمین اضافه کړۍ',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddUser(),
              ),
            );
          },
          backgroundColor: colors.buttonColor,
          foregroundColor: colors.helperWhiteColor,
          child: Icon(Icons.account_circle_outlined),
        ),
      ],
    );
  }
}
