import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: _themeColor,
      accentColor: _themeColor,
      fontFamily: 'OpenSans',
      brightness: Brightness.light,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: Colors.black,
              side: BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)))),
    );
  }

  static ThemeData dark() {
    return ThemeData(
        primaryColor: Colors.black,
        disabledColor: Colors.grey,
        brightness: Brightness.dark,
        accentColor: _themeColor,
        cardColor: Color(0xff373737),
        scaffoldBackgroundColor: Color(0xff1f1f1f),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                primary: Colors.black,
                side: BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)))),
        fontFamily: 'OpenSans');
  }

  static const Color _themeColor = Color(0xffFFC324);

  static const Color _accentColor = Color(0xff1A54F8);
  static const Color _textBlack = Colors.black;

  static Color get textBlack => _textBlack;

  static Color get themeColor => _themeColor;
  static Color get accentColor => _accentColor;
}
