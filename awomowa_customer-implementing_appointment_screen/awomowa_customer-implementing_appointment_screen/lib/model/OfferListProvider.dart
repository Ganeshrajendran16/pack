import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/responsemodels/offer_list_response_model.dart';
import 'package:awomowa/utils/SharedPreferences.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class OfferListProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;
  String userName = '';
  String searchString = "";

  OfferListResponse offerListResponse;
  SharedPrefManager prefManager = SharedPrefManager();

  Future<void> getOfferList() async {
    userName = await prefManager.getUsername();
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "userStoreList",
      "searchString": searchString,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    offerListResponse = OfferListResponse.fromJson(await loadApi(
        params: params,
        apiUrl: SHOPS,
        onError: (e) {
          isError = true;
        }));

    if (offerListResponse.storeList == null) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

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
