import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/update_list_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class UpdateListProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  UpdatesListResponse updatesListResponse;

  Future<void> getUpdates() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "vendorUpdateHistory",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    updatesListResponse = UpdatesListResponse.fromJson(await loadApi(
        params: params,
        apiUrl: OFFER_LIST,
        onError: (e) {
          isError = true;
        }));

    if (updatesListResponse.histories == null) {
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
