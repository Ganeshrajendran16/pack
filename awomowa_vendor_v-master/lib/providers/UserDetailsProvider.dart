import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/countries_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class UserDetailsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  CountriesResponse countriesResponse;

  UserDetailsProvider() {
    getCountries();
  }

  Future<void> getCountries() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "countriesList",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    countriesResponse = CountriesResponse.fromJson(await loadApi(
        params: params,
        apiUrl: VENDOR_DETAILS,
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

  Map<String, dynamic> userDetailsSubmitResponse;

  Future<void> submitDetails(
      String name,
      String mobileNumber,
      String mailId,
      String addressLine1,
      String addressLine2,
      String pinCode,
      String city,
      String country,
      String description,
      Map<String, dynamic> shopTiming) async {
    toggleLoading();
    var formData = FormData.fromMap({
      "apiMethod": "vendorProfileUpdate",
      "firstName": name,
      "phoneNumber": mobileNumber,
      "emailId": mailId,
      'shopAddress1': addressLine1,
      'shopAddress2': addressLine2,
      'shopPincode': pinCode,
      'shopCity': city,
      'shopCountry': country,
      'shopDescription': description,
      'shopTiming': shopTiming,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    });

    userDetailsSubmitResponse = await loadApi(
        params: formData,
        apiUrl: PROFILE_UPDATE,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }
}
