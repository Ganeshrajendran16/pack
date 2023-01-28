class VendorDetailsResponse {
  String status;
  String message;
  MerchantInformations merchantInformations;

  VendorDetailsResponse({this.status, this.message, this.merchantInformations});

  VendorDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    merchantInformations = json['merchantInformations'] != null
        ? new MerchantInformations.fromJson(json['merchantInformations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.merchantInformations != null) {
      data['merchantInformations'] = this.merchantInformations.toJson();
    }
    return data;
  }
}

class MerchantInformations {
  String merchantId;
  String merchantCode;
  String firstName;
  String lastName;
  var dob;
  String contactNumber;
  String mailId;
  var referalCode;
  String referenceNumber;
  String referenceCodeShareContent;
  String description;
  String profileImage;
  String banner1;
  String shopCategoryId;
  String shopCategoryName;
  String shopSubCategoryId;
  String shopSubCategoryName;
  String shopName;
  String shopActualName;
  var shopNumber;
  String shopContactNumber;
  String shopMailId;
  var website;
  String shopLogo;
  var shopArea;
  String shopCity;
  String shopPincode;
  var shopState;
  String shopCountryId;
  String shopCountryName;
  var notificationKey;
  String registrationStatus;
  ShopTimings shopTimings;
  String address1;
  String address2;
  String location;
  String gstCertificate;
  String bannerImage3;
  String bannerImage2;
  String bannerImage1;
  String lat;
  String lng;
  var gstNumber;
  String shopLocation;
  String shopAddress;
  String authKey;
  String shopFullAddress;
  String appColorCode;
  String isAllowToRenewal;
  String isSubscriptionActive;
  String subscriptionRemainingDays;
  String subscriptionEndDate;
  String qrCodeUrl;

  MerchantInformations(
      {this.merchantId,
      this.merchantCode,
      this.firstName,
      this.lastName,
      this.dob,
      this.contactNumber,
      this.mailId,
      this.referalCode,
      this.referenceNumber,
      this.referenceCodeShareContent,
      this.description,
      this.profileImage,
      this.banner1,
      this.shopCategoryId,
      this.shopCategoryName,
      this.shopSubCategoryId,
      this.shopSubCategoryName,
      this.shopName,
      this.shopActualName,
      this.shopNumber,
      this.shopContactNumber,
      this.shopMailId,
      this.website,
      this.shopLogo,
      this.shopArea,
      this.shopCity,
      this.shopPincode,
      this.shopState,
      this.shopCountryId,
      this.shopCountryName,
      this.notificationKey,
      this.registrationStatus,
      this.shopTimings,
      this.address1,
      this.address2,
      this.location,
      this.gstCertificate,
      this.bannerImage3,
      this.bannerImage2,
      this.bannerImage1,
      this.lat,
      this.lng,
      this.gstNumber,
      this.shopLocation,
      this.shopAddress,
      this.authKey,
      this.shopFullAddress,
      this.appColorCode,
      this.isAllowToRenewal,
      this.isSubscriptionActive,
      this.subscriptionRemainingDays,
      this.subscriptionEndDate,
      this.qrCodeUrl});

  MerchantInformations.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    merchantCode = json['merchantCode'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'];
    contactNumber = json['contactNumber'];
    mailId = json['mailId'];
    referalCode = json['referalCode'];
    referenceNumber = json['referenceNumber'];
    referenceCodeShareContent = json['referenceCodeShareContent'];
    description = json['description'];
    profileImage = json['profileImage'];
    banner1 = json['Banner_1'];
    shopCategoryId = json['shopCategoryId'];
    shopCategoryName = json['shopCategoryName'];
    shopSubCategoryId = json['shopSubCategoryId'];
    shopSubCategoryName = json['shopSubCategoryName'];
    shopName = json['ShopName'];
    shopActualName = json['shopActualName'];
    shopNumber = json['shopNumber'];
    shopContactNumber = json['shopContactNumber'];
    shopMailId = json['shopMailId'];
    website = json['website'];
    shopLogo = json['shopLogo'];
    shopArea = json['shopArea'];
    shopCity = json['shopCity'];
    shopPincode = json['shopPincode'];
    shopState = json['shopState'];
    shopCountryId = json['shopCountryId'];
    shopCountryName = json['shopCountryName'];
    notificationKey = json['notificationKey'];
    registrationStatus = json['registrationStatus'];
    shopTimings = json['shopTimings'] != null
        ? new ShopTimings.fromJson(json['shopTimings'])
        : null;
    address1 = json['address1'];
    address2 = json['address2'];
    location = json['location'];
    gstCertificate = json['gstCertificate'];
    bannerImage3 = json['bannerImage3'];
    bannerImage2 = json['bannerImage2'];
    bannerImage1 = json['bannerImage1'];
    lat = json['Lat'];
    lng = json['Lng'];
    gstNumber = json['gstNumber'];
    shopLocation = json['shopLocation'];
    shopAddress = json['ShopAddress'];
    authKey = json['authKey'];
    shopFullAddress = json['shopFullAddress'];
    appColorCode = json['appColorCode'];
    isAllowToRenewal = json['isAllowToRenewal'];
    isSubscriptionActive = json['isSubscriptionActive'];
    subscriptionRemainingDays = json['subscriptionRemainingDays'];
    subscriptionEndDate = json['subscriptionEndDate'];
    qrCodeUrl = json['qrCodeUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = this.merchantId;
    data['merchantCode'] = this.merchantCode;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dob'] = this.dob;
    data['contactNumber'] = this.contactNumber;
    data['mailId'] = this.mailId;
    data['referalCode'] = this.referalCode;
    data['referenceNumber'] = this.referenceNumber;
    data['referenceCodeShareContent'] = this.referenceCodeShareContent;
    data['description'] = this.description;
    data['profileImage'] = this.profileImage;
    data['Banner_1'] = this.banner1;
    data['shopCategoryId'] = this.shopCategoryId;
    data['shopCategoryName'] = this.shopCategoryName;
    data['shopSubCategoryId'] = this.shopSubCategoryId;
    data['shopSubCategoryName'] = this.shopSubCategoryName;
    data['ShopName'] = this.shopName;
    data['shopActualName'] = this.shopActualName;
    data['shopNumber'] = this.shopNumber;
    data['shopContactNumber'] = this.shopContactNumber;
    data['shopMailId'] = this.shopMailId;
    data['website'] = this.website;
    data['shopLogo'] = this.shopLogo;
    data['shopArea'] = this.shopArea;
    data['shopCity'] = this.shopCity;
    data['shopPincode'] = this.shopPincode;
    data['shopState'] = this.shopState;
    data['shopCountryId'] = this.shopCountryId;
    data['shopCountryName'] = this.shopCountryName;
    data['notificationKey'] = this.notificationKey;
    data['registrationStatus'] = this.registrationStatus;
    if (this.shopTimings != null) {
      data['shopTimings'] = this.shopTimings.toJson();
    }
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['location'] = this.location;
    data['gstCertificate'] = this.gstCertificate;
    data['bannerImage3'] = this.bannerImage3;
    data['bannerImage2'] = this.bannerImage2;
    data['bannerImage1'] = this.bannerImage1;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['gstNumber'] = this.gstNumber;
    data['shopLocation'] = this.shopLocation;
    data['ShopAddress'] = this.shopAddress;
    data['authKey'] = this.authKey;
    data['shopFullAddress'] = this.shopFullAddress;
    data['appColorCode'] = this.appColorCode;
    data['isAllowToRenewal'] = this.isAllowToRenewal;
    data['isSubscriptionActive'] = this.isSubscriptionActive;
    data['subscriptionRemainingDays'] = this.subscriptionRemainingDays;
    data['subscriptionEndDate'] = this.subscriptionEndDate;
    data['qrCodeUrl'] = this.qrCodeUrl;
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
