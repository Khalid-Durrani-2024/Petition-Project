import 'package:flutter/material.dart';
import 'package:petition/Screens/Login.dart';
import '../Authentication/AuthData.dart';
import '../Colors/Colors.dart';
import '../Widgets/Drawer.dart';
import 'Admin.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: colors.backgroundColor,
        child: userType == 'admin'
            ? DesignedDrawer()
            : userType == 'university'
                ? DrawerForUniversity()
                : userType == 'Faculty'
                    ? DrawerForFaculty()
                    : Drawer(),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(
            255, 15, 31, 253), // Changed background color of the app bar
        foregroundColor: Colors.white,
        title: Text('د اسنادو د لیږد را لیږد مدیریتی سیسیتم'),
      ),
      body: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map userData = {};

  getUserData() async {
    try {
      return userData = await AuthData().getSharedData();
    } catch (e) {
      print('Error retrieving user data: ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Icon(Icons.error_outline_outlined));
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildUserCard(),
                  SizedBox(height: 20),
                  _buildSettingsForm(width, height),
                ],
              ),
            );
          } else {
            return Text('معلومات پیدا نشول');
          }
        },
      ),
    );
  }

  Widget _buildUserCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  userData['name'] ?? 'معلومات لاوډ نه شول',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(userData['email'] ?? 'معلومات لاوډ نه شول',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
            SizedBox(width: 20),
            CircleAvatar(
              radius: 30,
              child: Icon(Icons.verified_user_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsForm(double width, double height) {
    return Container(
      width: width * 0.8,
      constraints: BoxConstraints(maxWidth: 800),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white10,
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              'پروفایل اداره کړۍ',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          _buildSettingsSection('تنظیم اکونټ', [
            _buildSettingsTile(
              icon: Icons.person_outline,
              title: 'استعمالوونکي نوم',
              subtitle: userData['name'],
              onTap: () {
                // Navigate to username change screen
              },
            ),
            _buildSettingsTile(
              icon: Icons.email_outlined,
              title: 'ایمیل',
              subtitle: userData['email'] ?? 'ندی تعین شوی',
              onTap: () {
                // Navigate to email change screen
              },
            ),
            _buildSettingsTile(
              icon: Icons.lock_outline,
              title: 'پټ نوم',
              subtitle: '*****',
              onTap: () {
                // Navigate to password change screen
              },
            ),
          ]),
          SizedBox(height: 20),
          _buildSettingsSection('نور معلومات', [
            _buildSettingsTile(
              icon: Icons.notifications_outlined,
              title: 'خبرداری ',
              onTap: () {
                // Navigate to notifications settings screen
              },
            ),
            _buildSettingsTile(
              icon: Icons.language_outlined,
              title: 'ژبی',
              onTap: () {
                // Navigate to language settings screen
              },
            ),
          ]),
          SizedBox(height: 20),
          _buildSettingsTile(
            icon: Icons.logout_outlined,
            title: 'بهر وتل',
            onTap: () {
              setState(() {
                AuthData().deleteShared();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              });
            },
            titleColor: Colors.white,
            tileColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 10),
        ...tiles,
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color titleColor = Colors.black,
    Color tileColor = Colors.white,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: titleColor),
        title: Text(title, style: TextStyle(color: titleColor)),
        subtitle: subtitle != null
            ? Text(subtitle, style: TextStyle(color: titleColor))
            : null,
        onTap: onTap,
        tileColor: tileColor,
      ),
    );
  }
}
