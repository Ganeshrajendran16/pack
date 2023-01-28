import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static const THEME_STATUS = "THEMESTATUS";
  static const AUTH_KEY = "authkey";
  static const IS_LOGGED_IN = "isloggedin";
  static const USER_NAME = "username";
  static const GENDER = "gender";
  static const DOB = "dateofbirth";
  static const EMAIL = "email";
  static const MOBILENUMBER = "mobilenm";
  static const PIC = "pic";
  static const ISNEWNOTIFICATIONCAME = "isnewnoticc";
  static bool isNewNotified = false;
  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }

  setAuthKey(String authKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AUTH_KEY, authKey);
  }

  Future<String> getAuthKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AUTH_KEY) ?? null;
  }

  setNewNotification(bool isnewNotificationCame) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(ISNEWNOTIFICATIONCAME, isnewNotificationCame);
  }

  Future<bool> isNewNotificationCame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(ISNEWNOTIFICATIONCAME) ?? true;
  }

  setLoggedIn(bool isloggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_LOGGED_IN, isloggedIn);
  }

  Future<bool> getLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_LOGGED_IN) ?? false;
  }

  setUsername(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_NAME, name);
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_NAME) ?? 'john doe';
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  setEmail(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EMAIL, name);
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(EMAIL) ?? '';
  }

  setMobile(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(MOBILENUMBER, mobile);
  }

  Future<String> getMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(MOBILENUMBER) ?? '';
  }

  setDob(String dob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(DOB, dob);
  }

  Future<String> getDob() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DOB) ?? '';
  }

  setGender(String gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(GENDER, gender);
  }

  Future<String> getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(GENDER) ?? '';
  }

  setProfilePic(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PIC, url);
  }

  Future<String> getProfilePic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PIC) ?? '';
  }
}
