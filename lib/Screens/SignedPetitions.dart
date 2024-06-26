import 'package:flutter/material.dart';

import '../Colors/Colors.dart';
import 'Maktob.dart';

class SignedPetitions extends StatelessWidget {
  const SignedPetitions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('امضا شوي مکتوبونه'),
        centerTitle: true,
        backgroundColor: colors.textFieldColor,
        foregroundColor: colors.helperWhiteColor,
      ),
      body: Signed(),
    );
  }
}

//actual screen

class Signed extends StatefulWidget {
  const Signed({super.key});

  @override
  State<Signed> createState() => _SignedState();
}

class _SignedState extends State<Signed> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      color: colors.backgroundColor,
      width: width,
      height: height,
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(30),
        itemCount: Petitions.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width > 500 ? 4 : 1),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _resend(context, index);
            },
            child: Card(
              child: ListTile(
                textColor: colors.helperWhiteColor,
                tileColor: colors.textFieldColor,
                title: Text(
                  Petitions[index]['Date'],
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text(
                  Petitions[index]['Text'],
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//show dialog on resending

_resend(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: colors.backgroundColor,
        title: Text(
          'غواړۍ چی مکتوب بیرته ولیګۍ وزارت ته',
          style: TextStyle(color: colors.helperWhiteColor),
          textAlign: TextAlign.center,
        ),
        content: Text(
          Petitions[index]['Text'],
          style: TextStyle(color: colors.helperWhiteColor),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(colors.buttonColor),
            ),
            onPressed: () {
              print('Resend Ptitioon button');
              Navigator.pop(context);
            },
            child: Icon(
              Icons.done,
              color: colors.helperWhiteColor,
            ),
          ),
        ],
      );
    },


    
  );
}
