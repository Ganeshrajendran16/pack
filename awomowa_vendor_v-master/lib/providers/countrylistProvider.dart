import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/about_us_response.dart';
import 'package:awomowa_vendor/reponse_models/countrylist.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class ContryCodeListnum extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;
  Countrycodelist countrycodelist;

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

Countrycodelistnum(){
  contrycodelist();

}
  

  Future<void> contrycodelist() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "countriesPhonecodeList",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

  countrycodelist= Countrycodelist.fromJson(await loadApi(
        params: params,
        apiUrl: CONTRYCODE,

        onError: (e) {
          isError = true;
        }));

    if(ContryCodeListnum == null) {
      isEmpty = true;
    }

    toggleLoading();
  }
}
