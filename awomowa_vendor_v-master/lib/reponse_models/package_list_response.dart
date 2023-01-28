class PackageDetailsResponse {
  String status;
  String message;
  List<PackageInforamtion> packageInforamtion;

  PackageDetailsResponse({this.status, this.message, this.packageInforamtion});

  PackageDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['packageInforamtion'] != null) {
      packageInforamtion = new List<PackageInforamtion>();
      json['packageInforamtion'].forEach((v) {
        packageInforamtion.add(new PackageInforamtion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.packageInforamtion != null) {
      data['packageInforamtion'] =
          this.packageInforamtion.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackageInforamtion {
  String packageId;
  String packageName;
  String packageCode;
  String packageAmount;
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
