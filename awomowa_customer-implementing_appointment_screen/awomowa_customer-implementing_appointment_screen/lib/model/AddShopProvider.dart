import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/responsemodels/add_shop_response.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class AddShopProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isFound = true;
  AddShopResponse verifyShopResponse;
  Map<String, dynamic> addShopRespnose;

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  searchShop(String referenceNo) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "findStoreUsingReferenceNo",
      "referenceNumber": referenceNo.toUpperCase().trim(),
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    verifyShopResponse = AddShopResponse.fromJson(await loadApi(
        params: params,
        apiUrl: SEARCH_SHOP,
        onError: (e) {
          isError = true;
        }));

    if (verifyShopResponse.status == 'success') {
      isFound = true;
    } else {
      isFound = false;
    }

    toggleLoading();
  }

  addShop(String shopId, String nickName) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "addUserStore",
      "storeId": shopId,
      "nickName": nickName,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    addShopRespnose = await loadApi(
        params: params,
        apiUrl: SEARCH_SHOP,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }
}
