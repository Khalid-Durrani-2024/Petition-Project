import 'package:flutter/material.dart';
import 'package:petition/Screens/AddUniversities.dart';
import 'package:petition/Screens/UpdateUniversities.dart';

import '../Colors/Colors.dart';

class Universities extends StatelessWidget {
  const Universities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: colors.helperWhiteColor,
        backgroundColor: colors.textFieldColor,
        title: Text('پوهنتونونه'),
      ),
      body: UniversitiesScreen(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colors.backgroundColor,
        foregroundColor: colors.helperWhiteColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddUniversity(),
            ),
          );
        },
        label: Text('پوهنتون اضافه کړۍ'),
      ),
    );
  }
}

class UniversitiesScreen extends StatefulWidget {
  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  List _universities = [
    'سید جمالدین پوهنتون',
    'کابل پوهنتون',
    'پوهنتون ننګرهار',
    'شیخ زاهد پوهنتون'
  ];

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colors.backgroundColor,
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(30),
        itemCount: _universities.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: currentWidth > 500 ? 4 : 1),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              UpdateUniversity(context);
            },
            child: Card(
              child: ListTile(
                textColor: colors.helperWhiteColor,
                tileColor: colors.textFieldColor,
                title: Text(
                  _universities[index],
                  textAlign: TextAlign.right,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Icon(
                        Icons.school_outlined,
                        color: colors.helperWhiteColor,
                        size: 150,
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: colors.helperWhiteColor,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '۳۲۱',
                        style: TextStyle(fontSize: 30),
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
  }
}
