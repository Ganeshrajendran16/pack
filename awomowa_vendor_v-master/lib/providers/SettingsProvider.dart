import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/vendor_details_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String shopName = '';
  String category = '';
  String logoUrl = '';
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  SettingsProvider() {
    getShopDetails();
  }
  VendorDetailsResponse vendorDetailsResponse;

  getShopDetails() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "merchantDetails",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    vendorDetailsResponse = VendorDetailsResponse.fromJson(await loadApi(
        params: params,
        apiUrl: VENDOR_DETAILS,
        onError: (e) {
          isError = true;
        }));

    shopName = vendorDetailsResponse.merchantInformations.shopName;
    category = vendorDetailsResponse.merchantInformations.shopCategoryName;
    logoUrl = vendorDetailsResponse.merchantInformations.shopLogo;

    toggleLoading();
  }
}
