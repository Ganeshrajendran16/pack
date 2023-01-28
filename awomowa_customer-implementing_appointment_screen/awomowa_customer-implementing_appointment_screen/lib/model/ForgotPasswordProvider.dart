import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  Map<String, dynamic> requestOtpResponse;
  Map<String, dynamic> resetPasswordResponse;

  Future<void> requestOtp(String mobileNumber) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "userForgotPassword",
      "username": mobileNumber,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    requestOtpResponse = await loadApi(
        params: params,
        apiUrl: FORGOT_PASS,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }

  resetPassword(String password, String confirmPassword) async {
    toggleLoading();
    Map<String, dynamic> params = {
      "apiMethod": "changePassword",
      "password": password,
      "confirmPassword": confirmPassword,
      "userId": requestOtpResponse['userId'],
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    resetPasswordResponse = await loadApi(
        params: params,
        apiUrl: FORGOT_PASS,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }
}
