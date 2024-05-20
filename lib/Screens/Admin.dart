import 'package:flutter/material.dart';
import '../Assets/NetworkImages.dart';
import '../Colors/Colors.dart';

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
    'ټــــــول مکتوبونه',
    'لیږل شوي مکتوبونه',
    'راغلي مکتوبونه',
    'پوهنتونونه',
    'سیټینګ',
  ];
  List<Icon> adminIcons = const [
    Icon(
      Icons.storage_outlined,
      size: 50,
    ),
    Icon(
      Icons.call_made_outlined,
      size: 50,
    ),
    Icon(
      Icons.call_received_outlined,
      size: 50,
    ),
    Icon(
      Icons.person_add_outlined,
      size: 50,
    ),
    Icon(
      Icons.settings_outlined,
      size: 50,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: colors.backgroundColor),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(ministryImage),
                        radius: 80,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'کنږ پوهنتون',
                        style: TextStyle(color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: adminList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 20),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: colors.buttonColor,
                                spreadRadius: 0.2,
                                offset: const Offset(3, 2))
                          ],
                          color: colors.textFieldColor,
                          borderRadius: BorderRadius.circular(22)),
                      width: width / 8,
                      height: height / 4,
                      child: ListTile(
                        title: Text(
                          adminList[index],
                          style: TextStyle(color: colors.helperWhiteColor),
                        ),
                        subtitle: adminIcons[index],
                        iconColor: Colors.grey.shade400,
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
