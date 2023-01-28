import 'dart:io';

import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/units_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditOfferProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;

  Map<String, dynamic> deactivateOfferResponse;
  Map<String, dynamic> addNewOfferResponse;
  Map<String, dynamic> republishResponse;
  UnitsResponse unitsResponse;

  Future<void> deactivateOffer(String broadCastId) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "removeBroadcast",
      "broadcastId": broadCastId,
      "mobileUniqueCode": "jana1221"
    };

    deactivateOfferResponse = await loadApi(
        params: params,
        apiUrl: OFFER_LIST,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }

  EditOfferProvider() {
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

  Future<void> rePublishOffer(String newDate, String id) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "productBroadcast",
      "expireDate": newDate,
      "republishedBroadcastId": id,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    republishResponse = await loadApi(
        params: FormData.fromMap(params),
        apiUrl: BROADCAST,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }

  Future<void> editOffer(String productName, String description, String price,
      int selectedUnitIndex, String expiryDate, String id, File image) async {
    toggleLoading();

    Map<String, dynamic> map = {
      "apiMethod": "productBroadcast",
      "expireDate": expiryDate,
      "price": price,
      "unit": unitsResponse.unitList[selectedUnitIndex].unitId,
      "comments": description,
      "productName": productName,
      "republishedBroadcastId": id,
      "broadcastType": 'offer',
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    if (image != null) {
      map['productImage'] = await MultipartFile.fromFile(image.path,
          filename: '${getRandString(10)}.jpg');
    }

    var formData = FormData.fromMap(map);

    addNewOfferResponse = await loadApi(
        params: formData,
        apiUrl: BROADCAST,
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
