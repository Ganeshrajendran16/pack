class LoginResponse {
  String status;
  String message;
  MerchantInformations merchantInformations;

  LoginResponse({this.status, this.message, this.merchantInformations});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  String firstName;
  String lastName;
  String contactNumber;
  String mailId;
  var profileImage;
  String shopCategoryId;
  String shopCategoryName;
  String shopSubCategoryId;
  String shopSubCategoryName;
  String shopName;
  String shopContactNumber;
  String shopMailId;
  String shopLogo;
  String registrationStatus;
  String shopAddress;
  String authKey;

  MerchantInformations(
      {this.merchantId,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.mailId,
      this.profileImage,
      this.shopCategoryId,
      this.shopCategoryName,
      this.shopSubCategoryId,
      this.shopSubCategoryName,
      this.shopName,
      this.shopContactNumber,
      this.shopMailId,
      this.shopLogo,
      this.registrationStatus,
      this.shopAddress,
      this.authKey});

  MerchantInformations.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contactNumber = json['contactNumber'];
    mailId = json['mailId'];
    profileImage = json['profileImage'];
    shopCategoryId = json['shopCategoryId'];
    shopCategoryName = json['shopCategoryName'];
    shopSubCategoryId = json['shopSubCategoryId'];
    shopSubCategoryName = json['shopSubCategoryName'];
    shopName = json['ShopName'];
    shopContactNumber = json['shopContactNumber'];
    shopMailId = json['shopMailId'];
    shopLogo = json['shopLogo'];
    registrationStatus = json['registrationStatus'];
    shopAddress = json['ShopAddress'];
    authKey = json['authKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = this.merchantId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['contactNumber'] = this.contactNumber;
    data['mailId'] = this.mailId;
    data['profileImage'] = this.profileImage;
    data['shopCategoryId'] = this.shopCategoryId;
    data['shopCategoryName'] = this.shopCategoryName;
    data['shopSubCategoryId'] = this.shopSubCategoryId;
    data['shopSubCategoryName'] = this.shopSubCategoryName;
    data['ShopName'] = this.shopName;
    data['shopContactNumber'] = this.shopContactNumber;
    data['shopMailId'] = this.shopMailId;
    data['shopLogo'] = this.shopLogo;
    data['registrationStatus'] = this.registrationStatus;
    data['ShopAddress'] = this.shopAddress;
    data['authKey'] = this.authKey;
    return data;
  }
}
