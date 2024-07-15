import 'package:flutter/material.dart';
import 'package:petition/Screens/Faculty.dart';
import 'package:petition/Screens/Maktob.dart';
import 'package:petition/Screens/Setting.dart';
import 'package:petition/Screens/SignedPetitions.dart';
import 'package:petition/Screens/Universities.dart';
import '../Assets/NetworkImages.dart';
import '../Authentication/AuthData.dart';
import '../Colors/Colors.dart';
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //for the user section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            color: colors.textFieldColor,
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(ministryImage),
                    radius: 40,
                  ),
                ),
                Text(
                  userName,
                  style:
                      TextStyle(fontSize: 24, color: colors.helperWhiteColor),
                ),
                Text(
                  userEmail,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
          //For the Middle Section
          Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'کور پاڼه',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Admin(),
                        ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.book_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'ټول مکتوبونه',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Maktob(
                            index: 0,
                          ),
                        ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'نوی مکتوب ولیږۍ',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Maktob(index: 0),
                        ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.forward_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'لیږل شوي مکتوبونه',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Maktob(index: 1),
                        ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.done_all_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'امضاء شوي مکتوبونه',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignedPetitions(),));

                    },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.school_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'پوهنتونونه',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Universities(),
                        ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'سیټینګ',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(
                        context).push(
                        MaterialPageRoute(
                          builder: (context) => Setting(),
                        ));
                  },
                ),
              ],
            ),
          ),
          Divider(),
          //For the End Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'معلومات',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    showAboutDialog(context: context

                    );

                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.exit_to_app_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'وتل',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
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
                ),
              ],
            ),
          )
        ],
      ),
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //for the user section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            color: colors.textFieldColor,
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(ministryImage),
                    radius: 40,
                  ),
                ),
                Text(
                  userName,
                  style:
                      TextStyle(fontSize: 24, color: colors.helperWhiteColor),
                ),
                Text(
                  userEmail,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
          //For the Middle Section
          Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [

                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.book_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'ټول مکتوبونه',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Maktob(index: 0),));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.school_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'پوهنځی اضافه کړۍ',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Faculty(),));
                    },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'سیټینګ',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Setting(),));
                  },
                ),
              ],
            ),
          ),
          Divider(),
          //For the End Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'معلومات',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    showAboutDialog(context: context);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.exit_to_app_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'وتل',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
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
                ),
              ],
            ),
          )
        ],
      ),
    );
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //for the user section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            color: colors.textFieldColor,
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(ministryImage),
                    radius: 40,
                  ),
                ),
                Text(
                  userName,
                  style:
                      TextStyle(fontSize: 24, color: colors.helperWhiteColor),
                ),
                Text(
                  userEmail,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
          //For the Middle Section
          Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.book_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'پوهنتون ته راغلي مکتوبونه',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Maktob(index: 10),));

                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'سیټینګ',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Setting(),),);
                  },
                ),
              ],
            ),
          ),
          Divider(),
          //For the End Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'معلومات',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    showAboutDialog(context: context);
                     },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.exit_to_app_outlined,
                        size: 30,
                        color: colors.helperWhiteColor,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'وتل',
                        style: TextStyle(
                            fontSize: 18, color: colors.helperWhiteColor),
                      ),
                    ],
                  ),
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
