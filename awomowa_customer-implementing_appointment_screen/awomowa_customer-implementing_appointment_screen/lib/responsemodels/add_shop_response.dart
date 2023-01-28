class AddShopResponse {
  String status;
  String message;
  VendorDetails vendorDetails;

  AddShopResponse({this.status, this.message, this.vendorDetails});

  AddShopResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vendorDetails = json['vendorDetails'] != null
        ? new VendorDetails.fromJson(json['vendorDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.vendorDetails != null) {
      data['vendorDetails'] = this.vendorDetails.toJson();
    }
    return data;
  }
}

class VendorDetails {
  String vendorId;
  String firstName;
  String lastName;
  String contactNumber;
  String mailId;
  String shopCategoryId;
  String shopCategoryName;
  String shopSubCategoryId;
  String shopSubCategoryName;
  String shopAddressLine1;
  String shopAddressLine2;
  String shopName;
  String shopContactNumber;
  String shopWhatsappNumber;
  String shopMailId;
  String shopLogo;
  String description;
  String shopArea;
  String shopCity;
  String referenceNumber;
  String shopPincode;
  String shopState;
  String registrationStatus;
  String shopAddress;
  var notificationKey;
  String appColorCode;
  String shopShareContent;
  String referenceCodeShareContent;

  VendorDetails(
      {this.vendorId,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.mailId,
      this.shopCategoryId,
      this.shopCategoryName,
      this.shopSubCategoryId,
      this.shopSubCategoryName,
      this.shopAddressLine1,
      this.shopAddressLine2,
      this.shopName,
      this.shopContactNumber,
      this.shopWhatsappNumber,
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
      this.shopShareContent,
      this.referenceCodeShareContent});

  VendorDetails.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendorId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contactNumber = json['contactNumber'];
    mailId = json['mailId'];
    shopCategoryId = json['shopCategoryId'];
    shopCategoryName = json['shopCategoryName'];
    shopSubCategoryId = json['shopSubCategoryId'];
    shopSubCategoryName = json['shopSubCategoryName'];
    shopAddressLine1 = json['ShopAddressLine1'];
    shopAddressLine2 = json['ShopAddressLine2'];
    shopName = json['ShopName'];
    shopContactNumber = json['shopContactNumber'];
    shopWhatsappNumber = json['shopWhatsappNumber'];
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
    shopShareContent = json['shopShareContent'];
    referenceCodeShareContent = json['referenceCodeShareContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorId'] = this.vendorId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['contactNumber'] = this.contactNumber;
    data['mailId'] = this.mailId;
    data['shopCategoryId'] = this.shopCategoryId;
    data['shopCategoryName'] = this.shopCategoryName;
    data['shopSubCategoryId'] = this.shopSubCategoryId;
    data['shopSubCategoryName'] = this.shopSubCategoryName;
    data['ShopAddressLine1'] = this.shopAddressLine1;
    data['ShopAddressLine2'] = this.shopAddressLine2;
    data['ShopName'] = this.shopName;
    data['shopContactNumber'] = this.shopContactNumber;
    data['shopWhatsappNumber'] = this.shopWhatsappNumber;
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
    data['shopShareContent'] = this.shopShareContent;
    data['referenceCodeShareContent'] = this.referenceCodeShareContent;
    return data;
  }
}
