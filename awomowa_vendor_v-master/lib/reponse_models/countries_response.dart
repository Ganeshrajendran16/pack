class CountriesResponse {
  String status;
  String message;
  List<Countries> countries;

  CountriesResponse({this.status, this.message, this.countries});

  CountriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['countries'] != null) {
      countries = new List<Countries>();
      json['countries'].forEach((v) {
        countries.add(new Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.countries != null) {
      data['countries'] = this.countries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  String id;
  String sortname;
  String name;
  String phonecode;
  String keyType;
  String pincodeLabel;
  String regex;
  String status;
  String createdAt;
  String updatedAt;

  Countries(
      {this.id,
      this.sortname,
      this.name,
      this.phonecode,
      this.keyType,
      this.pincodeLabel,
      this.regex,
      this.status,
      this.createdAt,
      this.updatedAt});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sortname = json['sortname'];
    name = json['name'];
    phonecode = json['phonecode'];
    keyType = json['keyType'];
    pincodeLabel = json['pincodeLabel'];
    regex = json['regex'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sortname'] = this.sortname;
    data['name'] = this.name;
    data['phonecode'] = this.phonecode;
    data['keyType'] = this.keyType;
    data['pincodeLabel'] = this.pincodeLabel;
    data['regex'] = this.regex;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
