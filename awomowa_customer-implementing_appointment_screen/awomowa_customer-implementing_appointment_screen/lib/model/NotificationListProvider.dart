import 'package:awomowa/connection/api_urls.dart';
import 'package:awomowa/connection/repository.dart';
import 'package:awomowa/responsemodels/notification_list_reponse.dart';
import 'package:awomowa/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class NotificationListProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;
  NotificationListResponse notificationListResponse;
  toggleLoading() {
    isLoading = !isLoading;
    if (isLoading) {
      isError = false;
    }
    notifyListeners();
  }

  NotificationListProvider() {
    getNotificationList();
  }

  Future<void> getNotificationList() async {
    toggleLoading();
    Map<String, String> params = {
      "apiMethod": "userNotificationsList",
      "mobileUniqueCode": MOBILE_UNIQUE_CODE
    };

    notificationListResponse = NotificationListResponse.fromJson(await loadApi(
        params: params,
        apiUrl: OFFER_LIST,
        onError: (e) {
          isError = true;
        }));

    if (notificationListResponse.offerStores == null ||
        notificationListResponse.offerStores.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    toggleLoading();
  }
}
