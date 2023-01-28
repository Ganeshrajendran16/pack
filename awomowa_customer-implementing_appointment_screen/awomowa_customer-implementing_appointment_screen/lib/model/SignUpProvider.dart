import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class SignUpProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  FirebaseMessaging messaging;

  Map<String, dynamic> requestOtpResponse;
  Map<String, dynamic> signUpResponse;

  Future<void> requestOtp(
      String name, String mobileNumber, String mailId) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "getOtpRequest",
      "name": name,
      "contactNumber": mobileNumber,
      "mailId": mailId,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    requestOtpResponse = await loadApi(
        params: params,
        apiUrl: OTP_REQUEST,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }

  Future<void> signUp(
      String name,
      String mobileNumber,
      String mailId,
      String gender,
      String dob,
      String password,
      String confirmPassword,
      String otp) async {
    toggleLoading();
    messaging = FirebaseMessaging.instance;
    var formData = FormData.fromMap({
      'apiMethod': 'addNewUser',
      'firstName': name,
      'contactNumber': mobileNumber,
      'mailId': mailId,
      'gender': gender,
      'dob': dob,
      'password': password,
      "notificationKey": await messaging.getToken(),
      'confirmPassword': confirmPassword,
      'otp': otp,
    });

    signUpResponse = await loadApi(
        params: formData,
        apiUrl: SIGN_UP,
        onError: (e) {
          isError = true;
        });

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
