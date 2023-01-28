import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class SplashScreenProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  Map<String, dynamic> registrationDetailsResponse;

  Future<void> checkRegistrationDetails() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "vendorRegistrationStatus",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    registrationDetailsResponse = await loadApi(
        params: params,
        apiUrl: STATUS,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }
}
