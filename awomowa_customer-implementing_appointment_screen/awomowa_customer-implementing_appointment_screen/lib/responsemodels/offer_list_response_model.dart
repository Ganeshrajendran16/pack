class OfferListResponse {
  String status;
  String message;
  List<StoreList> storeList;

  OfferListResponse({this.status, this.message, this.storeList});

  OfferListResponse.fromJson(Map<String, dynamic> json) {
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
  List<dynamic> shopTimings;
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
    if (this.shopTimings != null) {
      data['shopTimings'] = this.shopTimings.map((v) => v.toJson()).toList();
    }
    data['shopShareContent'] = this.shopShareContent;
    data['shopNickName'] = this.shopNickName;
    data['shopAddedTime'] = this.shopAddedTime;
    data['offerCounts'] = this.offerCounts;
    return data;
  }
}
