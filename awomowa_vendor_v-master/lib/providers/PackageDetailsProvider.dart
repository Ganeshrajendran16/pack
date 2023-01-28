import 'package:awomowa_vendor/connection/api_urls.dart';
import 'package:awomowa_vendor/connection/repository.dart';
import 'package:awomowa_vendor/reponse_models/package_list_response.dart';
import 'package:awomowa_vendor/utils/app_constants.dart';
import 'package:flutter/foundation.dart';

class PackageDetailsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  PackageDetailsResponse packageDetailsResponse;
  Map<String, dynamic> packageSubscribeResponse;
  Map<String, dynamic> couponCodeResponse = {};

  resetCouponResponse() {
    couponCodeResponse = {};
    notifyListeners();
  }

  PackageDetailsProvider() {
    getPackageDetails();
  }

  Future<void> getPackageDetails() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "packageList",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    packageDetailsResponse = PackageDetailsResponse.fromJson(await loadApi(
        params: params,
        apiUrl: PACKAGE,
        onError: (e) {
          isError = true;
        }));

    toggleLoading();
  }

  Future<void> verifyCouponCode(String amount, String couponCode) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "validateCoupen",
      "amount": amount,
      "coupenCode": couponCode
    };

    couponCodeResponse = await loadApi(
        params: params,
        apiUrl: COUPON,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }

  subscribePackage(bool isNew) async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": isNew ? "packageSelection" : "packageRenewual",
      "packageId": packageDetailsResponse.packageInforamtion[0].packageId,
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    packageSubscribeResponse = await loadApi(
        params: params,
        apiUrl: PACKAGE,
        onError: (e) {
          isError = true;
        });

    toggleLoading();
  }
}
