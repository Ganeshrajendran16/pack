class SubscriptionInfoResponse {
  String status;
  String message;
  String totalOffersCnt;
  String totalUpdatesCnt;
  String activeOfferCnt;
  String inActiveOffersCnt;
  String totalCustomersCnt;
  String expireDate;
  String noDaystoExpire;
  Details details;

  SubscriptionInfoResponse(
      {this.status,
      this.message,
      this.totalOffersCnt,
      this.totalUpdatesCnt,
      this.activeOfferCnt,
      this.inActiveOffersCnt,
      this.totalCustomersCnt,
      this.expireDate,
      this.noDaystoExpire,
      this.details});

  SubscriptionInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalOffersCnt = json['totalOffersCnt'];
    totalUpdatesCnt = json['totalUpdatesCnt'];
    activeOfferCnt = json['activeOfferCnt'];
    inActiveOffersCnt = json['inActiveOffersCnt'];
    totalCustomersCnt = json['totalCustomersCnt'];
    expireDate = json['expireDate'];
    noDaystoExpire = json['noDaystoExpire'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalOffersCnt'] = this.totalOffersCnt;
    data['totalUpdatesCnt'] = this.totalUpdatesCnt;
    data['activeOfferCnt'] = this.activeOfferCnt;
    data['inActiveOffersCnt'] = this.inActiveOffersCnt;
    data['totalCustomersCnt'] = this.totalCustomersCnt;
    data['expireDate'] = this.expireDate;
    data['noDaystoExpire'] = this.noDaystoExpire;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    return data;
  }
}

class Details {
  String packageAmount;
  String packageDescription;
  String packageCode;
  String packageName;
  String packageId;
  String isOffer;
  String offerType;
  String offerAmount;
  String actualAmount;
  String expireDate;
  String packageStartDate;
  String packageGraceDate;
  int currentWeek;
  String displayMessage;
  String color;
  String autoSubscription;
  String allowToRenew;
  String status;
  String dateStatus;
  List<Limitations> limitations;
  ApkDisplay apkDisplay;

  Details(
      {this.packageAmount,
      this.packageDescription,
      this.packageCode,
      this.packageName,
      this.packageId,
      this.isOffer,
      this.offerType,
      this.offerAmount,
      this.actualAmount,
      this.expireDate,
      this.packageStartDate,
      this.packageGraceDate,
      this.currentWeek,
      this.displayMessage,
      this.color,
      this.autoSubscription,
      this.allowToRenew,
      this.status,
      this.dateStatus,
      this.limitations,
      this.apkDisplay});

  Details.fromJson(Map<String, dynamic> json) {
    packageAmount = json['packageAmount'];
    packageDescription = json['packageDescription'];
    packageCode = json['packageCode'];
    packageName = json['packageName'];
    packageId = json['packageId'];
    isOffer = json['isOffer'];
    offerType = json['offerType'];
    offerAmount = json['offerAmount'];
    actualAmount = json['actualAmount'];
    expireDate = json['expireDate'];
    packageStartDate = json['packageStartDate'];
    packageGraceDate = json['packageGraceDate'];
    currentWeek = json['currentWeek'];
    displayMessage = json['displayMessage'];
    color = json['color'];
    autoSubscription = json['autoSubscription'];
    allowToRenew = json['allowToRenew'];
    status = json['status'];
    dateStatus = json['date_status'];
    if (json['limitations'] != null) {
      limitations = new List<Limitations>();
      json['limitations'].forEach((v) {
        limitations.add(new Limitations.fromJson(v));
      });
    }
    apkDisplay = json['apkDisplay'] != null
        ? new ApkDisplay.fromJson(json['apkDisplay'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageAmount'] = this.packageAmount;
    data['packageDescription'] = this.packageDescription;
    data['packageCode'] = this.packageCode;
    data['packageName'] = this.packageName;
    data['packageId'] = this.packageId;
    data['isOffer'] = this.isOffer;
    data['offerType'] = this.offerType;
    data['offerAmount'] = this.offerAmount;
    data['actualAmount'] = this.actualAmount;
    data['expireDate'] = this.expireDate;
    data['packageStartDate'] = this.packageStartDate;
    data['packageGraceDate'] = this.packageGraceDate;
    data['currentWeek'] = this.currentWeek;
    data['displayMessage'] = this.displayMessage;
    data['color'] = this.color;
    data['autoSubscription'] = this.autoSubscription;
    data['allowToRenew'] = this.allowToRenew;
    data['status'] = this.status;
    data['date_status'] = this.dateStatus;
    if (this.limitations != null) {
      data['limitations'] = this.limitations.map((v) => v.toJson()).toList();
    }
    if (this.apkDisplay != null) {
      data['apkDisplay'] = this.apkDisplay.toJson();
    }
    return data;
  }
}

class Limitations {
  String limitId;
  String packageCode;
  String limitationName;
  String limitationDescription;
  String basedOn;
  String remaining;
  String details;
  String max;
  String limitMapId;

  Limitations(
      {this.limitId,
      this.packageCode,
      this.limitationName,
      this.limitationDescription,
      this.basedOn,
      this.remaining,
      this.details,
      this.max,
      this.limitMapId});

  Limitations.fromJson(Map<String, dynamic> json) {
    limitId = json['limitId'];
    packageCode = json['packageCode'];
    limitationName = json['limitationName'];
    limitationDescription = json['limitationDescription'];
    basedOn = json['basedOn'];
    remaining = json['remaining'];
    details = json['details'];
    max = json['max'];
    limitMapId = json['limitMapId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limitId'] = this.limitId;
    data['packageCode'] = this.packageCode;
    data['limitationName'] = this.limitationName;
    data['limitationDescription'] = this.limitationDescription;
    data['basedOn'] = this.basedOn;
    data['remaining'] = this.remaining;
    data['details'] = this.details;
    data['max'] = this.max;
    data['limitMapId'] = this.limitMapId;
    return data;
  }
}

class ApkDisplay {
  String productUploadLimit;
  String productUploadLimitMax;
  String productUploadLimitUsed;

  ApkDisplay(
      {this.productUploadLimit,
      this.productUploadLimitMax,
      this.productUploadLimitUsed});

  ApkDisplay.fromJson(Map<String, dynamic> json) {
    productUploadLimit = json['Product upload limit'];
    productUploadLimitMax = json['Product upload limit max'];
    productUploadLimitUsed = json['Product upload limit used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Product upload limit'] = this.productUploadLimit;
    data['Product upload limit max'] = this.productUploadLimitMax;
    data['Product upload limit used'] = this.productUploadLimitUsed;
    return data;
  }
}
