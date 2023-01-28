import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/login_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;

  LoginResponse loginResponse;

  Future<void> signIn(String mobileNumber, String password) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "merchantLogin",
      "username": mobileNumber,
      "password": password,
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

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }
}
