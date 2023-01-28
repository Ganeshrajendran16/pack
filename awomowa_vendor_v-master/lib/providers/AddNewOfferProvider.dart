import 'dart:io';

import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/units_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AddNewOfferProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  UnitsResponse unitsResponse;
  Map<String, dynamic> addNewOfferResponse;
  Map<String, dynamic> addNewUpdateResponse;

  AddNewOfferProvider() {
    getUnits();
  }

  Future<void> getUnits() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "unitList",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    unitsResponse = UnitsResponse.fromJson(await loadApi(
        params: params,
        apiUrl: UNIT,
        onError: (e) {
          isError = true;
        }));

    toggleLoading();
  }

  Future<void> addNewOffers(
      String productName,
      String description,
      String price,
      int selectedUnitIndex,
      String expiryDate,
      File image) async {
    toggleLoading();

    Map<String, dynamic> map = {
      "apiMethod": "productBroadcast",
      "expireDate": expiryDate,
      "price": price,
      "unit": unitsResponse.unitList[selectedUnitIndex].unitId,
      "comments": description,
      "productName": productName,
      "broadcastType": 'offer',
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    if (image != null) {
      map["productImage"] = await MultipartFile.fromFile(image.path,
          filename: '${getRandString(10)}.jpg');
    }

    addNewOfferResponse = await loadApi(
        params: FormData.fromMap(map),
        apiUrl: BROADCAST,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }

  Future<void> addNewUpdate(String description, File image) async {
    toggleLoading();

    Map<String, dynamic> map = {
      "apiMethod": "productBroadcast",
      "comments": description,
      "broadcastType": 'update',
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    if (image != null) {
      map["productImage"] = await MultipartFile.fromFile(image.path,
          filename: '${getRandString(10)}.jpg');
    }

    addNewUpdateResponse = await loadApi(
        params: FormData.fromMap(map),
        apiUrl: BROADCAST,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }
}
