class UnitsResponse {
  String status;
  String message;
  List<UnitList> unitList;

  UnitsResponse({this.status, this.message, this.unitList});

  UnitsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['unitList'] != null) {
      unitList = new List<UnitList>();
      json['unitList'].forEach((v) {
        unitList.add(new UnitList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.unitList != null) {
      data['unitList'] = this.unitList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnitList {
  String unitId;
  String unitCode;
  String unitName;
  String status;
  String createdAt;
  String updatedAt;

  UnitList(
      {this.unitId,
      this.unitCode,
      this.unitName,
      this.status,
      this.createdAt,
      this.updatedAt});

  UnitList.fromJson(Map<String, dynamic> json) {
    unitId = json['unitId'];
    unitCode = json['unitCode'];
    unitName = json['unitName'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitId'] = this.unitId;
    data['unitCode'] = this.unitCode;
    data['unitName'] = this.unitName;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
