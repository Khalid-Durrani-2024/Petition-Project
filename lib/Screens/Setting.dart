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
    child: userType=='admin'? DesignedDrawer(): userType=='university'?DrawerForUniversity():userType=='Faculty'? DrawerForFaculty():Drawer(),
),
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.textFieldColor,
        title: Text('سیټینګ'),
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
    return Scaffold(

      backgroundColor: colors.backgroundColor,

      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasError){
            return Center(child: Icon(Icons.error_outline_outlined),);
          }else if(snapshot.hasData){
            return    SingleChildScrollView(

              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  _buildUserCard(),
                  SizedBox(height: 20),
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
                  ),
                ],
              ),
            );

        }else {
            return Text('معلومات پیدا نشول');
          }
        },
      ),
    );
  }

  Widget _buildUserCard() {
    return Card(
color: colors.textFieldColor,

      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  userData['name'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: colors.helperWhiteColor),
                ),
                SizedBox(height: 5),
                Text(userData['email'] ?? 'معلومات لاوډ نه شول',style: TextStyle(color: colors.helperWhiteColor),),
              ],
            ),SizedBox(width: 20,),
            CircleAvatar(
                radius: 30,
                child: Icon(Icons.verified_user_outlined)
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> tiles) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colors.helperWhiteColor),
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

    Color titleColor = Colors.white,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(

        trailing: Icon(icon, color: colors.helperWhiteColor),
        title: Text(title, style: TextStyle(color: titleColor),textAlign: TextAlign.end),
        subtitle: subtitle != null ? Text(subtitle,style: TextStyle(color: colors.helperWhiteColor),textAlign: TextAlign.end,) : null,

        onTap: onTap,
        tileColor: colors.textFieldColor,
      ),
    );
  }
}
