class TransactionHistoryResponse {
  String status;
  String message;
  List<TransactionHistory> transactionHistory;

  TransactionHistoryResponse(
      {this.status, this.message, this.transactionHistory});

  TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['transactionHistory'] != null) {
      transactionHistory = new List<TransactionHistory>();
      json['transactionHistory'].forEach((v) {
        transactionHistory.add(new TransactionHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.transactionHistory != null) {
      data['transactionHistory'] =
          this.transactionHistory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionHistory {
  String logId;
  String packageId;
  String packageCode;
  String vendorId;
  String subscribeStartDate;
  String subscribeEndDate;
  String subscribeGraceDate;
  String timeStamp;
  PackageInforamtion packageInforamtion;

  TransactionHistory(
      {this.logId,
        this.packageId,
        this.packageCode,
        this.vendorId,
        this.subscribeStartDate,
        this.subscribeEndDate,
        this.subscribeGraceDate,
        this.timeStamp,
        this.packageInforamtion});

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    logId = json['logId'];
    packageId = json['packageId'];
    packageCode = json['packageCode'];
    vendorId = json['vendorId'];
    subscribeStartDate = json['subscribeStartDate'];
    subscribeEndDate = json['subscribeEndDate'];
    subscribeGraceDate = json['subscribeGraceDate'];
    timeStamp = json['timeStamp'];
    packageInforamtion = json['packageInforamtion'] != null
        ? new PackageInforamtion.fromJson(json['packageInforamtion'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logId'] = this.logId;
    data['packageId'] = this.packageId;
    data['packageCode'] = this.packageCode;
    data['vendorId'] = this.vendorId;
    data['subscribeStartDate'] = this.subscribeStartDate;
    data['subscribeEndDate'] = this.subscribeEndDate;
    data['subscribeGraceDate'] = this.subscribeGraceDate;
    data['timeStamp'] = this.timeStamp;
    if (this.packageInforamtion != null) {
      data['packageInforamtion'] = this.packageInforamtion.toJson();
    }
    return data;
  }
}

class PackageInforamtion {
  String packageId;
  String packageName;
  String packageCode;
  String packageAmount;
  String isOffer;
  String offerType;
  String offerAmount;
  String actualAmount;
  String taxPercentage;
  String taxAmount;
  String packageAmountwithTax;
  String packageDescription;
  String createdAt;
  String updatedAt;
  List<LimitaionDetails> limitaionDetails;

  PackageInforamtion(
      {this.packageId,
        this.packageName,
        this.packageCode,
        this.packageAmount,
        this.isOffer,
        this.offerType,
        this.offerAmount,
        this.actualAmount,
        this.taxPercentage,
        this.taxAmount,
        this.packageAmountwithTax,
        this.packageDescription,
        this.createdAt,
        this.updatedAt,
        this.limitaionDetails});

  PackageInforamtion.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'];
    packageName = json['packageName'];
    packageCode = json['packageCode'];
    packageAmount = json['packageAmount'];
    isOffer = json['isOffer'];
    offerType = json['offerType'];
    offerAmount = json['offerAmount'];
    actualAmount = json['actualAmount'];
    taxPercentage = json['TaxPercentage'];
    taxAmount = json['TaxAmount'];
    packageAmountwithTax = json['packageAmountwithTax'];
    packageDescription = json['packageDescription'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['limitaionDetails'] != null) {
      limitaionDetails = new List<LimitaionDetails>();
      json['limitaionDetails'].forEach((v) {
        limitaionDetails.add(new LimitaionDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageId'] = this.packageId;
    data['packageName'] = this.packageName;
    data['packageCode'] = this.packageCode;
    data['packageAmount'] = this.packageAmount;
    data['isOffer'] = this.isOffer;
    data['offerType'] = this.offerType;
    data['offerAmount'] = this.offerAmount;
    data['actualAmount'] = this.actualAmount;
    data['TaxPercentage'] = this.taxPercentage;
    data['TaxAmount'] = this.taxAmount;
    data['packageAmountwithTax'] = this.packageAmountwithTax;
    data['packageDescription'] = this.packageDescription;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.limitaionDetails != null) {
      data['limitaionDetails'] =
          this.limitaionDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LimitaionDetails {
  String limitationId;
  String limitationKey;
  String limitationName;
  String limitationDescription;
  String basedOn;
  String limitCount;
  String displayContent;
  String status;
  String createdAt;
  String updatedAt;

  LimitaionDetails(
      {this.limitationId,
        this.limitationKey,
        this.limitationName,
        this.limitationDescription,
        this.basedOn,
        this.limitCount,
        this.displayContent,
        this.status,
        this.createdAt,
        this.updatedAt});

  LimitaionDetails.fromJson(Map<String, dynamic> json) {
    limitationId = json['limitationId'];
    limitationKey = json['limitationKey'];
    limitationName = json['limitationName'];
    limitationDescription = json['limitationDescription'];
    basedOn = json['basedOn'];
    limitCount = json['limitCount'];
    displayContent = json['displayContent'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limitationId'] = this.limitationId;
    data['limitationKey'] = this.limitationKey;
    data['limitationName'] = this.limitationName;
    data['limitationDescription'] = this.limitationDescription;
    data['basedOn'] = this.basedOn;
    data['limitCount'] = this.limitCount;
    data['displayContent'] = this.displayContent;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
