import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/responsemodels/manage_stores_response.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class ManageShopsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  ManageShopResponse manageShopResponse;
  Map<String, dynamic> removeShopResponse;
  Map<String, dynamic> changeNickNameResponse;
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  ManageShopsProvider() {
    //getShopList();
  }

  void getShopList() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "userStoreList",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    manageShopResponse = ManageShopResponse.fromJson(await loadApi(
        params: params,
        apiUrl: SEARCH_SHOP,
        onError: (e) {
          isError = true;
        }));

    if (manageShopResponse.storeList == null) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    toggleLoading();
  }

  Future<void> changeNickName(String nickName, String shopId) async {
    toggleLoading();
    Map<String, dynamic> params = {
      "apiMethod": "editNickName",
      "storeId": shopId,
      "nickName": nickName,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    changeNickNameResponse = await loadApi(
        params: params,
        apiUrl: SEARCH_SHOP,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
    getShopList();
  }

  Future<void> removeShop(String shopId) async {
    toggleLoading();
    Map<String, dynamic> params = {
      "apiMethod": "removeUserStore",
      "storeId": [shopId],
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    removeShopResponse = await loadApi(
        params: params,
        apiUrl: SEARCH_SHOP,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
    getShopList();
  }
}
