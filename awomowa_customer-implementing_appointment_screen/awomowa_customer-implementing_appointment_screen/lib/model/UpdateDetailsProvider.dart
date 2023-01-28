import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/responsemodels/update_details_response.dart';
import 'package:flutter/cupertino.dart';

class UpdateDetailsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;
  UpdateDetailsResponse updateDetailsResponse;
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  Future<void> getUpdateDetails(String broadcastId) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "userNotificationsList",
      "broadcastId": broadcastId,
      "mobileUniqueCode": "jana1221"
    };

    updateDetailsResponse = UpdateDetailsResponse.fromJson(await loadApi(
        params: params,
        apiUrl: OFFER_LIST,
        onError: (e) {
          isError = true;
        }));

    if (updateDetailsResponse.offerStores == null) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    toggleLoading();
  }
}
