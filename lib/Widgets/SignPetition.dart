import 'package:flutter/material.dart';
import 'package:petition/models/ApiService.dart';
import 'package:petition/models/SignPetitionModel.dart';

import '../Colors/Colors.dart';

SignPetition(BuildContext context, Map petition, Map User) {
  print(petition);
  TextEditingController response = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.red,
            ),
          )
        ],
        title: Center(
            child: Text(
          'د مکتوب ځواب',
          style: TextStyle(color: colors.helperWhiteColor),
        )),
        backgroundColor: colors.backgroundColor,
        content: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  label: Icon(
                    Icons.edit_outlined,
                    color: colors.helperWhiteColor,
                  ),
                ),
                textAlign: TextAlign.right,
                style: TextStyle(color: colors.helperWhiteColor),
                maxLines: 3,
                controller: response,
              ),
              SizedBox(
                height: 10,
              ),
              IconButton(
                onPressed: () async {
                  final signPetition = SignPetitionModel(
                      user_id: User['id'],
                      signed_at: DateTime.now().toString().substring(0, 10),
                      petition_id: petition['id'],
                      comment: response.text);

                  int signResponseCode = await ApiService()
                      .signPetition(signPetition, 'signatures');
                  if (signResponseCode == 201) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: colors.backgroundColor,
                        showCloseIcon: true,
                        content: Text('مکتوب امضاء شو په بریالی توګه')));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        showCloseIcon: true,
                        content: Text('ستونزه ده')));
                    Navigator.pop(context);
                  }
                },
                icon: Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ],
          )),
        ),
      );
    },
  );
}
