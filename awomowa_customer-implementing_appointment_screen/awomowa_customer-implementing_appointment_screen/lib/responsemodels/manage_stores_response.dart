class ManageShopResponse {
  String status;
  String message;
  List<StoreList> storeList;

  ManageShopResponse({this.status, this.message, this.storeList});

  ManageShopResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['storeList'] != null) {
      storeList = new List<StoreList>();
      json['storeList'].forEach((v) {
        storeList.add(new StoreList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.storeList != null) {
      data['storeList'] = this.storeList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreList {
  String storeId;
  String firstName;
  String lastName;
  String contactNumber;
  String mailId;
  String shopCategoryId;
  String shopCategoryName;
  String shopSubCategoryId;
  String shopSubCategoryName;
  String shopName;
  String shopActualName;
  String shopContactNumber;
  String shopWhatsappNumber;
  String shopAddressLine1;
  String shopAddressLine2;
  String shopMailId;
  String shopLogo;
  String description;
  var shopArea;
  String shopCity;
  String referenceNumber;
  String shopPincode;
  var shopState;
  String registrationStatus;
  String shopAddress;
  var notificationKey;
  String appColorCode;
  ShopTimings shopTimings;
  String shopShareContent;
  String shopNickName;
  String shopAddedTime;
  String offerCounts;

  StoreList(
      {this.storeId,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.mailId,
      this.shopCategoryId,
      this.shopCategoryName,
      this.shopSubCategoryId,
      this.shopSubCategoryName,
      this.shopName,
      this.shopActualName,
      this.shopContactNumber,
      this.shopWhatsappNumber,
      this.shopAddressLine1,
      this.shopAddressLine2,
      this.shopMailId,
      this.shopLogo,
      this.description,
      this.shopArea,
      this.shopCity,
      this.referenceNumber,
      this.shopPincode,
      this.shopState,
      this.registrationStatus,
      this.shopAddress,
      this.notificationKey,
      this.appColorCode,
      this.shopTimings,
      this.shopShareContent,
      this.shopNickName,
      this.shopAddedTime,
      this.offerCounts});

  StoreList.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contactNumber = json['contactNumber'];
    mailId = json['mailId'];
    shopCategoryId = json['shopCategoryId'];
    shopCategoryName = json['shopCategoryName'];
    shopSubCategoryId = json['shopSubCategoryId'];
    shopSubCategoryName = json['shopSubCategoryName'];
    shopName = json['ShopName'];
    shopActualName = json['shopActualName'];
    shopContactNumber = json['shopContactNumber'];
    shopWhatsappNumber = json['shopWhatsappNumber'];
    shopAddressLine1 = json['ShopAddressLine1'];
    shopAddressLine2 = json['ShopAddressLine2'];
    shopMailId = json['shopMailId'];
    shopLogo = json['shopLogo'];
    description = json['description'];
    shopArea = json['shopArea'];
    shopCity = json['shopCity'];
    referenceNumber = json['referenceNumber'];
    shopPincode = json['shopPincode'];
    shopState = json['shopState'];
    registrationStatus = json['registrationStatus'];
    shopAddress = json['ShopAddress'];
    notificationKey = json['notificationKey'];
    appColorCode = json['appColorCode'];
    shopTimings = json['shopTimings'] != null
        ? new ShopTimings.fromJson(json['shopTimings'])
        : null;
    shopShareContent = json['shopShareContent'];
    shopNickName = json['shopNickName'];
    shopAddedTime = json['shopAddedTime'];
    offerCounts = json['offerCounts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeId'] = this.storeId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['contactNumber'] = this.contactNumber;
    data['mailId'] = this.mailId;
    data['shopCategoryId'] = this.shopCategoryId;
    data['shopCategoryName'] = this.shopCategoryName;
    data['shopSubCategoryId'] = this.shopSubCategoryId;
    data['shopSubCategoryName'] = this.shopSubCategoryName;
    data['ShopName'] = this.shopName;
    data['shopActualName'] = this.shopActualName;
    data['shopContactNumber'] = this.shopContactNumber;
    data['shopWhatsappNumber'] = this.shopWhatsappNumber;
    data['ShopAddressLine1'] = this.shopAddressLine1;
    data['ShopAddressLine2'] = this.shopAddressLine2;
    data['shopMailId'] = this.shopMailId;
    data['shopLogo'] = this.shopLogo;
    data['description'] = this.description;
    data['shopArea'] = this.shopArea;
    data['shopCity'] = this.shopCity;
    data['referenceNumber'] = this.referenceNumber;
    data['shopPincode'] = this.shopPincode;
    data['shopState'] = this.shopState;
    data['registrationStatus'] = this.registrationStatus;
    data['ShopAddress'] = this.shopAddress;
    data['notificationKey'] = this.notificationKey;
    data['appColorCode'] = this.appColorCode;
    if (this.shopTimings != null) {
      data['shopTimings'] = this.shopTimings.toJson();
    }
    data['shopShareContent'] = this.shopShareContent;
    data['shopNickName'] = this.shopNickName;
    data['shopAddedTime'] = this.shopAddedTime;
    data['offerCounts'] = this.offerCounts;
    return data;
  }
}

class ShopTimings {
  Monday monday;
  Monday tuesday;
  Monday wednesday;
  Monday thursday;
  Monday friday;
  Monday saturday;
  Monday sunday;

  ShopTimings(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  ShopTimings.fromJson(Map<String, dynamic> json) {
    monday =
        json['monday'] != null ? new Monday.fromJson(json['monday']) : null;
    tuesday =
        json['tuesday'] != null ? new Monday.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null
        ? new Monday.fromJson(json['wednesday'])
        : null;
    thursday =
        json['thursday'] != null ? new Monday.fromJson(json['thursday']) : null;
    friday =
        json['friday'] != null ? new Monday.fromJson(json['friday']) : null;
    saturday =
        json['saturday'] != null ? new Monday.fromJson(json['saturday']) : null;
    sunday =
        json['sunday'] != null ? new Monday.fromJson(json['sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monday != null) {
      data['monday'] = this.monday.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday.toJson();
    }
    if (this.friday != null) {
      data['friday'] = this.friday.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday.toJson();
    }
    if (this.sunday != null) {
      data['sunday'] = this.sunday.toJson();
    }
    return data;
  }
}

class Monday {
  String openingTime;
  String closeingTime;

  Monday({this.openingTime, this.closeingTime});

  Monday.fromJson(Map<String, dynamic> json) {
    openingTime = json['openingTime'];
    closeingTime = json['closeingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openingTime'] = this.openingTime;
    data['closeingTime'] = this.closeingTime;
    return data;
  }
}
