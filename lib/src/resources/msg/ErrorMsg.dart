import 'package:flutter/material.dart';

class ErrorMsg {
  static void showErrorMsg(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              new FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(ErrorMsg);
                },
              ),
            ],
          ),
    );
  }
}