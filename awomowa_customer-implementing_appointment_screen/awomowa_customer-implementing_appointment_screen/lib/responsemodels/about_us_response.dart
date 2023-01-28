class AbutUsResponse {
  String status;
  String message;
  AppContent appContent;

  AbutUsResponse({this.status, this.message, this.appContent});

  AbutUsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    appContent = json['appContent'] != null
        ? new AppContent.fromJson(json['appContent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.appContent != null) {
      data['appContent'] = this.appContent.toJson();
    }
    return data;
  }
}

class AppContent {
  String appName;
  String appShortName;
  String appLogo;
  String appFotter;
  String appDescription;
  String appVersion;
  String contact;
  String email;
  String website;
  String developedBy;
  String appLoginBgImg;
  String noOfDaysPackage;
  String retentionPeriod;
  String contactDescription;
  String emailDescription;
  String addressDescription;
  String websiteDescription;
  String contactUs;
  String privacyPolicy;
  String address;
  String broadcastShareContent;

  AppContent(
      {this.appName,
      this.appShortName,
      this.appLogo,
      this.appFotter,
      this.appDescription,
      this.appVersion,
      this.contact,
      this.email,
      this.website,
      this.developedBy,
      this.appLoginBgImg,
      this.noOfDaysPackage,
      this.retentionPeriod,
      this.contactDescription,
      this.emailDescription,
      this.addressDescription,
      this.websiteDescription,
      this.contactUs,
      this.privacyPolicy,
      this.address,
      this.broadcastShareContent});

  AppContent.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    appShortName = json['appShortName'];
    appLogo = json['appLogo'];
    appFotter = json['appFotter'];
    appDescription = json['appDescription'];
    appVersion = json['appVersion'];
    contact = json['contact'];
    email = json['email'];
    website = json['website'];
    developedBy = json['developedBy'];
    appLoginBgImg = json['appLoginBgImg'];
    noOfDaysPackage = json['noOfDaysPackage'];
    retentionPeriod = json['retentionPeriod'];
    contactDescription = json['contactDescription'];
    emailDescription = json['emailDescription'];
    addressDescription = json['addressDescription'];
    websiteDescription = json['websiteDescription'];
    contactUs = json['contactUs'];
    privacyPolicy = json['privacyPolicy'];
    address = json['address'];
    broadcastShareContent = json['broadcastShareContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appName'] = this.appName;
    data['appShortName'] = this.appShortName;
    data['appLogo'] = this.appLogo;
    data['appFotter'] = this.appFotter;
    data['appDescription'] = this.appDescription;
    data['appVersion'] = this.appVersion;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['website'] = this.website;
    data['developedBy'] = this.developedBy;
    data['appLoginBgImg'] = this.appLoginBgImg;
    data['noOfDaysPackage'] = this.noOfDaysPackage;
    data['retentionPeriod'] = this.retentionPeriod;
    data['contactDescription'] = this.contactDescription;
    data['emailDescription'] = this.emailDescription;
    data['addressDescription'] = this.addressDescription;
    data['websiteDescription'] = this.websiteDescription;
    data['contactUs'] = this.contactUs;
    data['privacyPolicy'] = this.privacyPolicy;
    data['address'] = this.address;
    data['broadcastShareContent'] = this.broadcastShareContent;
    return data;
  }
}
