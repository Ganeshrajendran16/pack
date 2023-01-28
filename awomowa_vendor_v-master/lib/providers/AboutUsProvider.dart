import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/about_us_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class AboutUsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;
  AbutUsResponse aboutUsResponse;

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  AboutUsProvider() {
    getAboutUsContent();
  }

  Future<void> getAboutUsContent() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "appContent",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    aboutUsResponse = AbutUsResponse.fromJson(await loadApi(
        params: params,
        apiUrl: ABOUT_US,
        onError: (e) {
          isError = true;
        }));

    if (aboutUsResponse == null) {
      isEmpty = true;
    }

    toggleLoading();
  }
}
