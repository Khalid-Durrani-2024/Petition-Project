import 'package:flutter/material.dart';
Message(bool isSuccess, BuildContext context,String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            child: Icon(
              Icons.close_outlined,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Icon(
          isSuccess == true ? Icons.check : Icons.dangerous_outlined,
          color: isSuccess == true ? Colors.green : Colors.red,
          size: 60,
        ),
        content: isSuccess == true
            ? Text('$message')
            : Text('$message'),
        contentTextStyle: TextStyle(color: Colors.black),
      );
    },
  );
}
