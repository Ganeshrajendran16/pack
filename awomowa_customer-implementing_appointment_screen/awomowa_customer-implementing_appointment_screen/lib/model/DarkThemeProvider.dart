import 'package:awomowa/utils/SharedPreferences.dart';
import 'package:flutter/foundation.dart';

class DarkThemeProvider with ChangeNotifier {
  SharedPrefManager darkThemePreference = SharedPrefManager();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
