import 'package:flutter/material.dart';
import '../Screens/Faculty.dart';
import '../Screens/Maktob.dart';
import '../Screens/Setting.dart';
import '../Screens/SignedFromUniversity.dart';
import '../Screens/SignedPetitions.dart';
import '../Screens/Universities.dart';
import '../models/ApiService.dart';
import '../Authentication/AuthData.dart';
import '../Screens/Admin.dart';
import '../Screens/Login.dart';
//Drawer Designed for Admin

class DesignedDrawer extends StatefulWidget {
  const DesignedDrawer({super.key});

  @override
  State<DesignedDrawer> createState() => _DesignedDrawerState();
}

class _DesignedDrawerState extends State<DesignedDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(220, 32, 42, 239),
            ),
            child: Center(
              child: Text(
                'د اسنادو د لیږد رالیږد مدیریتی سیستم',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'CustomFont',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _createDrawerItem(context, Icons.home_outlined, 'کور پاڼه',
              () => _navigateTo(context, Admin())),
          _createDrawerItem(context, Icons.book_outlined, 'ټول مکتوبونه',
              () => _navigateTo(context, Maktob(index: 0))),
          _createDrawerItem(
              context,
              Icons.forward_outlined,
              'لیږل شوي مکتوبونه',
              () => _navigateTo(context, Maktob(index: 1))),
          _createDrawerItem(
              context,
              Icons.done_all_outlined,
              'امضاء شوي مکتوبونه',
              () => _navigateTo(context, SignedPetitions())),
          _createDrawerItem(context, Icons.school_outlined, 'پوهنتونونه',
              () => _navigateTo(context, Universities())),
          _createDrawerItem(
              context, Icons.backup_outlined, 'بیک اپ', () => _backup(context)),
          _createDrawerItem(context, Icons.settings_outlined, 'سیټینګ',
              () => _navigateTo(context, Setting())),
          _createDrawerItem(context, Icons.info_outline, 'معلومات',
              () => _showAbout(context)),
          _createDrawerItem(context, Icons.exit_to_app_outlined, 'وتل',
              () => _logout(context)),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      BuildContext context, IconData icon, String text, Function() onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, Widget destination) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ));
  }

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

  void _backup(BuildContext context) async {
    try {
      int res = await ApiService().takeBackup('backup');
      if (res == 200) {
        _showDialog(
            context, 'بیک اپ له سیستم څخه واخستل شو', Icons.done, Colors.green);
      } else {
        _showDialog(
            context, 'مشکل رامنځته شو', Icons.error_outline, Colors.red);
      }
    } catch (e) {
      _showDialog(context, 'مشکل رامنځته شو', Icons.error_outline, Colors.red);
    }
  }

  void _showDialog(
      BuildContext context, String message, IconData icon, Color iconColor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          title: Icon(icon, color: iconColor),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: Colors.red),
            )
          ],
        );
      },
    );
  }
}

//Drawer Designed For Univeristy

class DrawerForUniversity extends StatefulWidget {
  const DrawerForUniversity({super.key});

  @override
  State<DrawerForUniversity> createState() => _DrawerForUniversityState();
}

class _DrawerForUniversityState extends State<DrawerForUniversity> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(220, 32, 42, 239),
            ),
            child: Center(
              child: Text(
                'د اسنادو مدیریت عصری کول',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'CustomFont',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Divider(),
          _createDrawerItem(context, Icons.book_outlined, 'ټول مکتوبونه',
              () => _navigateTo(context, Maktob(index: 9))),
          _createDrawerItem(
              context,
              Icons.check_box_outlined,
              'امضاء شوي مکتوبونه',
              () => _navigateTo(context, SignedFromUniversity())),
          _createDrawerItem(context, Icons.school_outlined, 'پوهنځی اضافه کړۍ',
              () => _navigateTo(context, Faculty())),
          _createDrawerItem(context, Icons.settings_outlined, 'سیټینګ',
              () => _navigateTo(context, Setting())),
          Divider(),
          _createDrawerItem(context, Icons.info_outline, 'معلومات',
              () => _showAbout(context)),
          _createDrawerItem(context, Icons.exit_to_app_outlined, 'وتل',
              () => _logout(context)),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      BuildContext context, IconData icon, String text, Function() onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, Widget destination) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => destination,
    ));
  }

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
}

//Drawer Designed For faculty
class DrawerForFaculty extends StatefulWidget {
  const DrawerForFaculty({super.key});

  @override
  State<DrawerForFaculty> createState() => _DrawerForFacultyState();
}

class _DrawerForFacultyState extends State<DrawerForFaculty> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(220, 32, 42, 239),
            ),
            child: Center(
              child: Text(
                'د اسنادو مدیریت عصری کول',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'CustomFont',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Divider(),
          _createDrawerItem(
              context,
              Icons.book_outlined,
              'پوهنځي ته راغلي مکتوبونه',
              () => _navigateTo(context, Maktob(index: 10))),
          _createDrawerItem(context, Icons.settings_outlined, 'سیټینګ',
              () => _navigateTo(context, Setting())),
          Divider(),
          _createDrawerItem(context, Icons.info_outline, 'معلومات',
              () => _showAbout(context)),
          _createDrawerItem(context, Icons.exit_to_app_outlined, 'وتل',
              () => _logout(context)),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      BuildContext context, IconData icon, String text, Function() onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, Widget destination) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ));
  }

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
}
