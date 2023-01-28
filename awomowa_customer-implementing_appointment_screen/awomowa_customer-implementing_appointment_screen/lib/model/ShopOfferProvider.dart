import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/responsemodels/shop_offers_response.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class ShopOfferProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isOffersEmpty = false;
  bool isUpdateEmpty = false;
  ShopOffersResponse shopOffersResponse;
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  Future<void> getShopOffers(String shopId) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "allVendorOfferUpdates",
      "shopId": shopId,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    shopOffersResponse = ShopOffersResponse.fromJson(await loadApi(
        params: params,
        apiUrl: OFFER_LIST,
        onError: (e) {
          isError = true;
        }));

    if (shopOffersResponse.updatesHistory == null ||
        shopOffersResponse.updatesHistory.isEmpty) {
      isUpdateEmpty = true;
    } else {
      isUpdateEmpty = false;
    }

    if (shopOffersResponse.activeOffers == null ||
        shopOffersResponse.activeOffers.isEmpty) {
      isOffersEmpty = true;
    } else {
      isOffersEmpty = false;
    }

    toggleLoading();
  }
}
