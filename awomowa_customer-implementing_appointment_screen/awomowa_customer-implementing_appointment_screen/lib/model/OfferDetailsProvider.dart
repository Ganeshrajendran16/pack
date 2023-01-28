import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/responsemodels/offer_details_response.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class OfferDetailsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;
  final String shopId;
  final String broadcastId;

  OfferDetailsResponse offerDetailsResponse;
  Map<String, dynamic> toggleLikeResponse;

  Future<void> getOfferDetails() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "shopOffersList",
      "shopId": shopId,
      "broadcastId": broadcastId,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    offerDetailsResponse = OfferDetailsResponse.fromJson(await loadApi(
        params: params,
        apiUrl: OFFER_LIST,
        onError: (e) {
          isError = true;
        }));

    if (offerDetailsResponse.offerStores == null ||
        offerDetailsResponse.offerStores.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    toggleLoading();
  }

  Future<void> toggleLike(String bId, bool isLike) async {
    Map<String, String> params = {
      "apiMethod": isLike ? 'removeLikes' : 'addLikes',
      "broadcastId": bId,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    toggleLikeResponse = await loadApi(
        params: params,
        apiUrl: LIKE_MGMT,
        onError: (e) {
          isError = true;
        });
  }

  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  OfferDetailsProvider(this.shopId, this.broadcastId) {
    getOfferDetails();
  }
}
