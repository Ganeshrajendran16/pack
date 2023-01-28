import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/offer_list_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class ManageOffersProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  OfferListResponse offerListResponse;

  // ManageOffersProvider() {
  //   getOfferList();
  // }

  Future<void> getOfferList() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "vendorHistory",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    offerListResponse = OfferListResponse.fromJson(await loadApi(
        params: params,
        apiUrl: OFFER_LIST,
        onError: (e) {
          isError = true;
        }));

    if (offerListResponse.histories == null) {
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
