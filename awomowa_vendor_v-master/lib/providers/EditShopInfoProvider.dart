import 'dart:io';

import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/category_list_response.dart';
import 'package:awomowa_vendor/reponse_models/countries_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class EditShopInfoProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;

  Map<String, dynamic> requestOtpResponse;
  Map<String, dynamic> signUpResponse;
  CategoryListResponse categoryListResponse;
  Map<String, dynamic> profileUpdateResponse;
  CountriesResponse countriesResponse;

  EditShopInfoProvider() {
    getCategories();
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

  Future<void> getCategories() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "CategoryList",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    categoryListResponse = CategoryListResponse.fromJson(await loadApi(
        params: params,
        apiUrl: CATEGORIES,
        onError: (e) {
          isError = true;
        }));

    toggleLoading();
  }

  Future<void> updateShopInfo(
      String shopName,
      String mobileNumber,
      String mailId,
      String addressLine1,
      String addressLine2,
      String city,
      String country,
      String PIN,
      int selectedCategoryIndex,
      int selectedSubCategoryIndex,
      String description,
      String username,
      String userMobileNumber,
      String userEmail,
      File shopLogo,
      Map<String, dynamic> shopTiming) async {
    toggleLoading();
    Map<String, dynamic> map = {
      "apiMethod": "vendorProfileUpdate",
      'shopName': shopName,
      'shopContactNumber': mobileNumber,
      'shopMailId': mailId,
      "firstName": username,
      "phoneNumber": userMobileNumber,
      "emailId": userEmail,
      'shopAddress1': addressLine1,
      'shopAddress2': addressLine2,
      'shopPincode': PIN,
      'shopCity': city,
      'shopCountry': country,
      'shopDescription': description,
      'shopTiming': shopTiming,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    if (shopLogo != null) {
      map['shopLogo'] = await MultipartFile.fromFile(shopLogo.path,
          filename: '${getRandString(10)}.jpg');
    }

    if (selectedCategoryIndex != null && selectedSubCategoryIndex != null) {
      map['shopCategoryId'] =
          categoryListResponse.categoryList[selectedCategoryIndex].categoryId;

      map['shopSubCategoryId'] = categoryListResponse
          .categoryList[selectedCategoryIndex]
          .subCategories[selectedSubCategoryIndex]
          .subCategeoryId;
    }

    profileUpdateResponse = await loadApi(
        params: FormData.fromMap(map),
        apiUrl: PROFILE_UPDATE,
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
