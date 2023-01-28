class ShopOffersResponse {
  String status;
  String message;
  MerchantInformations merchantInformations;
  List<ActiveOffers> activeOffers;
  List<UpdatesHistory> updatesHistory;

  ShopOffersResponse(
      {this.status,
      this.message,
      this.merchantInformations,
      this.activeOffers,
      this.updatesHistory});

  ShopOffersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    merchantInformations = json['merchantInformations'] != null
        ? new MerchantInformations.fromJson(json['merchantInformations'])
        : null;
    if (json['activeOffers'] != null) {
      activeOffers = new List<ActiveOffers>();
      json['activeOffers'].forEach((v) {
        activeOffers.add(new ActiveOffers.fromJson(v));
      });
    }
    if (json['updatesHistory'] != null) {
      updatesHistory = new List<UpdatesHistory>();
      json['updatesHistory'].forEach((v) {
        updatesHistory.add(new UpdatesHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.merchantInformations != null) {
      data['merchantInformations'] = this.merchantInformations.toJson();
    }
    if (this.activeOffers != null) {
      data['activeOffers'] = this.activeOffers.map((v) => v.toJson()).toList();
    }
    if (this.updatesHistory != null) {
      data['updatesHistory'] =
          this.updatesHistory.map((v) => v.toJson()).toList();
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
      this.appColorCode});

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

class ActiveOffers {
  String broadcastId;
  String broadcastCode;
  String broadcastType;
  String productName;
  String shopId;
  String shopName;
  String categoryId;
  String categoryName;
  String subcategoryId;
  String subcategoryName;
  String imageUrl;
  String expireDate;
  String price;
  String unitId;
  String unit;
  String comments;
  String status;
  var editBroadcastId;
  String republishedBroadcastId;
  String createdAt;
  String updatedAt;
  var viewedUserIds;
  String defaultUserAppLike;
  String shopLogo;
  String offerCounts;
  String appColorCode;
  String referenceCodeShareContent;
  String publishedDate;
  String isUserViewed;
  String shareContent;
  String isLiked;
  String noOfLikes;
  String notificationListDisplayContent;

  ActiveOffers(
      {this.broadcastId,
      this.broadcastCode,
      this.broadcastType,
      this.productName,
      this.shopId,
      this.shopName,
      this.categoryId,
      this.categoryName,
      this.subcategoryId,
      this.subcategoryName,
      this.imageUrl,
      this.expireDate,
      this.price,
      this.unitId,
      this.unit,
      this.comments,
      this.status,
      this.editBroadcastId,
      this.republishedBroadcastId,
      this.createdAt,
      this.updatedAt,
      this.viewedUserIds,
      this.defaultUserAppLike,
      this.shopLogo,
      this.offerCounts,
      this.appColorCode,
      this.referenceCodeShareContent,
      this.publishedDate,
      this.isUserViewed,
      this.shareContent,
      this.isLiked,
      this.noOfLikes,
      this.notificationListDisplayContent});

  ActiveOffers.fromJson(Map<String, dynamic> json) {
    broadcastId = json['broadcastId'];
    broadcastCode = json['broadcastCode'];
    broadcastType = json['broadcastType'];
    productName = json['productName'];
    shopId = json['shopId'];
    shopName = json['shopName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subcategoryId = json['subcategoryId'];
    subcategoryName = json['subcategoryName'];
    imageUrl = json['imageUrl'];
    expireDate = json['expireDate'];
    price = json['price'];
    unitId = json['unitId'];
    unit = json['unit'];
    comments = json['comments'];
    status = json['status'];
    editBroadcastId = json['editBroadcastId'];
    republishedBroadcastId = json['republishedBroadcastId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    viewedUserIds = json['viewedUserIds'];
    defaultUserAppLike = json['defaultUserAppLike'];
    shopLogo = json['shopLogo'];
    offerCounts = json['offerCounts'];
    appColorCode = json['appColorCode'];
    referenceCodeShareContent = json['referenceCodeShareContent'];
    publishedDate = json['publishedDate'];
    isUserViewed = json['isUserViewed'];
    shareContent = json['shareContent'];
    isLiked = json['isLiked'];
    noOfLikes = json['noOfLikes'];
    notificationListDisplayContent = json['notificationListDisplayContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['broadcastId'] = this.broadcastId;
    data['broadcastCode'] = this.broadcastCode;
    data['broadcastType'] = this.broadcastType;
    data['productName'] = this.productName;
    data['shopId'] = this.shopId;
    data['shopName'] = this.shopName;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['subcategoryId'] = this.subcategoryId;
    data['subcategoryName'] = this.subcategoryName;
    data['imageUrl'] = this.imageUrl;
    data['expireDate'] = this.expireDate;
    data['price'] = this.price;
    data['unitId'] = this.unitId;
    data['unit'] = this.unit;
    data['comments'] = this.comments;
    data['status'] = this.status;
    data['editBroadcastId'] = this.editBroadcastId;
    data['republishedBroadcastId'] = this.republishedBroadcastId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['viewedUserIds'] = this.viewedUserIds;
    data['defaultUserAppLike'] = this.defaultUserAppLike;
    data['shopLogo'] = this.shopLogo;
    data['offerCounts'] = this.offerCounts;
    data['appColorCode'] = this.appColorCode;
    data['referenceCodeShareContent'] = this.referenceCodeShareContent;
    data['publishedDate'] = this.publishedDate;
    data['isUserViewed'] = this.isUserViewed;
    data['shareContent'] = this.shareContent;
    data['isLiked'] = this.isLiked;
    data['noOfLikes'] = this.noOfLikes;
    data['notificationListDisplayContent'] =
        this.notificationListDisplayContent;
    return data;
  }
}

class UpdatesHistory {
  String broadcastId;
  String broadcastCode;
  String broadcastType;
  var productName;
  String shopId;
  String shopName;
  String categoryId;
  String categoryName;
  String subcategoryId;
  String subcategoryName;
  String imageUrl;
  String expireDate;
  var price;
  var unitId;
  String unit;
  String comments;
  String status;
  var editBroadcastId;
  var republishedBroadcastId;
  String createdAt;
  String updatedAt;
  var viewedUserIds;
  String defaultUserAppLike;
  String shopLogo;
  String offerCounts;
  String appColorCode;
  String referenceCodeShareContent;
  String publishedDate;
  String isUserViewed;
  String shareContent;
  String isLiked;
  String noOfLikes;
  String notificationListDisplayContent;

  UpdatesHistory(
      {this.broadcastId,
      this.broadcastCode,
      this.broadcastType,
      this.productName,
      this.shopId,
      this.shopName,
      this.categoryId,
      this.categoryName,
      this.subcategoryId,
      this.subcategoryName,
      this.imageUrl,
      this.expireDate,
      this.price,
      this.unitId,
      this.unit,
      this.comments,
      this.status,
      this.editBroadcastId,
      this.republishedBroadcastId,
      this.createdAt,
      this.updatedAt,
      this.viewedUserIds,
      this.defaultUserAppLike,
      this.shopLogo,
      this.offerCounts,
      this.appColorCode,
      this.referenceCodeShareContent,
      this.publishedDate,
      this.isUserViewed,
      this.shareContent,
      this.isLiked,
      this.noOfLikes,
      this.notificationListDisplayContent});

  UpdatesHistory.fromJson(Map<String, dynamic> json) {
    broadcastId = json['broadcastId'];
    broadcastCode = json['broadcastCode'];
    broadcastType = json['broadcastType'];
    productName = json['productName'];
    shopId = json['shopId'];
    shopName = json['shopName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subcategoryId = json['subcategoryId'];
    subcategoryName = json['subcategoryName'];
    imageUrl = json['imageUrl'];
    expireDate = json['expireDate'];
    price = json['price'];
    unitId = json['unitId'];
    unit = json['unit'];
    comments = json['comments'];
    status = json['status'];
    editBroadcastId = json['editBroadcastId'];
    republishedBroadcastId = json['republishedBroadcastId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    viewedUserIds = json['viewedUserIds'];
    defaultUserAppLike = json['defaultUserAppLike'];
    shopLogo = json['shopLogo'];
    offerCounts = json['offerCounts'];
    appColorCode = json['appColorCode'];
    referenceCodeShareContent = json['referenceCodeShareContent'];
    publishedDate = json['publishedDate'];
    isUserViewed = json['isUserViewed'];
    shareContent = json['shareContent'];
    isLiked = json['isLiked'];
    noOfLikes = json['noOfLikes'];
    notificationListDisplayContent = json['notificationListDisplayContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['broadcastId'] = this.broadcastId;
    data['broadcastCode'] = this.broadcastCode;
    data['broadcastType'] = this.broadcastType;
    data['productName'] = this.productName;
    data['shopId'] = this.shopId;
    data['shopName'] = this.shopName;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['subcategoryId'] = this.subcategoryId;
    data['subcategoryName'] = this.subcategoryName;
    data['imageUrl'] = this.imageUrl;
    data['expireDate'] = this.expireDate;
    data['price'] = this.price;
    data['unitId'] = this.unitId;
    data['unit'] = this.unit;
    data['comments'] = this.comments;
    data['status'] = this.status;
    data['editBroadcastId'] = this.editBroadcastId;
    data['republishedBroadcastId'] = this.republishedBroadcastId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['viewedUserIds'] = this.viewedUserIds;
    data['defaultUserAppLike'] = this.defaultUserAppLike;
    data['shopLogo'] = this.shopLogo;
    data['offerCounts'] = this.offerCounts;
    data['appColorCode'] = this.appColorCode;
    data['referenceCodeShareContent'] = this.referenceCodeShareContent;
    data['publishedDate'] = this.publishedDate;
    data['isUserViewed'] = this.isUserViewed;
    data['shareContent'] = this.shareContent;
    data['isLiked'] = this.isLiked;
    data['noOfLikes'] = this.noOfLikes;
    data['notificationListDisplayContent'] =
        this.notificationListDisplayContent;
    return data;
  }
}
