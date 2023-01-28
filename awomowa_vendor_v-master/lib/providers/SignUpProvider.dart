import 'dart:io';

import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/category_list_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class SignUpProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;

  Map<String, dynamic> requestOtpResponse;
  Map<String, dynamic> signUpResponse;
  CategoryListResponse categoryListResponse;

  SignUpProvider() {
    getCategories();
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

  Future<void> requestOtp(
      String shopName, String mobileNumber, String mailId) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "getOtpRequest",
      "shopName": shopName,
      "shopContactNumber": mobileNumber,
      "shopMailId": mailId,
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
      String shopName,
      String mobileNumber,
      String mailId,
      String password,
      String confirmPassword,
      File shopLogo,
      int categoryIndex,
      int subCategoryIndex) async {
    toggleLoading();
    var formData = FormData.fromMap({
      'apiMethod': 'addNewMerchant',
      'shopName': shopName,
      'shopContactNumber': mobileNumber,
      'shopMailId': mailId,
      'password': password,
      'confirmPassword': confirmPassword,
      'shopLogo': await MultipartFile.fromFile(shopLogo.path,
          filename: '${getRandString(10)}.jpg'),
      'shopCategoryId':
          categoryListResponse.categoryList[categoryIndex].categoryId,
      'shopSubCategoryId': categoryListResponse.categoryList[categoryIndex]
          .subCategories[subCategoryIndex].subCategeoryId
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
