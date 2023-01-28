import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/responsemodels/login_response.dart';
import 'package:awomowa/utils/SharedPreferences.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  FirebaseMessaging messaging;

  LoginResponse loginResponse;

  Future<void> signIn(String mobileNumber, String password) async {
    toggleLoading();
    messaging = FirebaseMessaging.instance;
    Map<String, String> params = {
      "apiMethod": "userLogin",
      "username": mobileNumber,
      "password": password,
      "notificationKey": await messaging.getToken(),
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    loginResponse = LoginResponse.fromJson(await loadApi(
        params: params,
        apiUrl: SIGN_IN,
        onError: (e) {
          isError = true;
        }));

    toggleLoading();
  }

  Future<void> signOut() async {
    toggleLoading();
    messaging = FirebaseMessaging.instance;
    Map<String, String> params = {
      "apiMethod": "userLogout",
      "notificationKey": await messaging.getToken(),
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    loginResponse = LoginResponse.fromJson(await loadApi(
        params: params,
        apiUrl: SIGN_OUT,
        onError: (e) {
          isError = true;
        }));
    SharedPrefManager prefManager = SharedPrefManager();
    await prefManager.logout();
    await FirebaseMessaging.instance.deleteToken();

    toggleLoading();
  }

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }
}
