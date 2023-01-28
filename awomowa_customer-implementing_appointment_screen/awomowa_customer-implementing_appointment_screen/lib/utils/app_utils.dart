import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  const AppUtils._();

  static void showToast(
    String text, {
    Color color = Colors.green,
    ToastGravity toastGravity,
    String webColor,
  }) {
    if (text == null) return;
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: toastGravity ?? ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      webBgColor: "linear-gradient(to right, #FF0000, #FF0000)",
      webPosition: "center",
      timeInSecForIosWeb: 3,
      fontSize: 14.0,
    );
  }
}
