import 'package:flutter/material.dart';

import '../Colors/Colors.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserScreen(),
    );
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final List<Map> Petitions = [
    {
      'id': 1,
      'Date': DateTime.now(),
      'Sender': 'Ali',
      'Text':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam dapibus consectetur lorem, pharetra fringilla tellus tempus ac. Nulla consequat enim in velit tempus, et venenatis lorem tempor. Duis pulvinar non mauris vel porttitor. Nulla porta eros vel tincidunt consequat. Sed dictum aliquet quam elementum efficitur. Maecenas elit nib'
    },
    {
      'id': 2,
      'Date': DateTime.now(),
      'Sender': 'Jan',
      'Text':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam dapibus consectetur lorem, pharetra fringilla tellus tempus ac. Nulla consequat enim in velit tempus, et venenatis lorem tempor. Duis pulvinar non mauris vel porttitor. Nulla porta eros vel tincidunt consequat. Sed dictum aliquet quam elementum efficitur. Maecenas elit nib'
    },
    {
      'id': 3,
      'Date': DateTime.now(),
      'Sender': 'Zahid',
      'Text':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam dapibus consectetur lorem, pharetra fringilla tellus tempus ac. Nulla consequat enim in velit tempus, et venenatis lorem tempor. Duis pulvinar non mauris vel porttitor. Nulla porta eros vel tincidunt consequat. Sed dictum aliquet quam elementum efficitur. Maecenas elit nib'
    },
    {
      'id': 4,
      'Date': DateTime.now(),
      'Sender': 'Khan',
      'Text':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam dapibus consectetur lorem, pharetra fringilla tellus tempus ac. Nulla consequat enim in velit tempus, et venenatis lorem tempor. Duis pulvinar non mauris vel porttitor. Nulla porta eros vel tincidunt consequat. Sed dictum aliquet quam elementum efficitur. Maecenas elit nib'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(color: colors.backgroundColor),
      width: width,
      height: height,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 340),
        itemCount: Petitions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(left: 350, right: 350, top: 20),
            color: colors.textFieldColor,
            child: ListTile(
              title: Text(
                Petitions[index]['Sender'],
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
