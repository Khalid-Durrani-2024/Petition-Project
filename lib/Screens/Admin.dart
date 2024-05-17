import 'package:flutter/material.dart';
import 'package:petition/Colors/Colors.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.textFieldColor,
        foregroundColor: colors.helperWhiteColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                InkWell(child: Icon(Icons.notifications_none_outlined)),
                Text(
                  'Notification',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                InkWell(child: Icon(Icons.logout_outlined)),
                Text(
                  'Log Out',
                  style: TextStyle(fontSize: 10),
                )
              ],
            )
          ],
        ),
      ),
      drawer: Drawer(),
      body: AdminScreen(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.textFieldColor,
        foregroundColor: colors.helperWhiteColor,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

//Admin Screen
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List adminList = [
    'ټــــــول عرایــــض',
    'لیږل شوي عرایض',
    'رالیږل شوي عرایض',
    'نوی استعمالوونکی اضافه کړۍ',
    'سیټینګ',
  ];
  List<Icon> adminIcons = const [
    Icon(Icons.storage_outlined),
    Icon(Icons.call_made_outlined),
    Icon(Icons.call_received_outlined),
    Icon(Icons.person_add_outlined),
    Icon(Icons.settings_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: colors.backgroundColor),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 340),
        itemCount: adminList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(left: 350, right: 350, top: 20),
            color: colors.textFieldColor,
            child: ListTile(
              hoverColor: colors.helperBlackColor,
              textColor: colors.helperWhiteColor,
              title: Text(
                adminList[index],
                textAlign: TextAlign.center,
              ),
              leading: adminIcons[index],
              iconColor: colors.helperWhiteColor,
            ),
          );
        },
      ),
    );
  }
}
