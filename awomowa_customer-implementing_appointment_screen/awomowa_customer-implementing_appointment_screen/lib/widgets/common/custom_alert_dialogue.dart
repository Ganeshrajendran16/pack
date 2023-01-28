import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomAlertDialog {
  const CustomAlertDialog(_);
  static void showdialog(
      {BuildContext context,
      String title,
      AlertType type,
      Widget content,
      String description,
      String positiveText,
      String negativeText,
      Function() positiveFunction,
      Function() negativeFunction}) {
    Alert(
      context: context,
      type: type,
      title: title,
      desc: description,
      content: content ?? SizedBox(),
      buttons: [
        DialogButton(
          onPressed: positiveFunction,
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: Text(
            positiveText,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: negativeFunction,
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: Text(
            negativeText,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }
}
