class LoginResponse {
  String status;
  String message;
  UserInformations userInformations;

  LoginResponse({this.status, this.message, this.userInformations});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userInformations = json['userInformations'] != null
        ? new UserInformations.fromJson(json['userInformations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userInformations != null) {
      data['userInformations'] = this.userInformations.toJson();
    }
    return data;
  }
}

class UserInformations {
  String id;
  String userId;
  String firstName;
  String lastName;
  String mailId;
  String authKey;
  String contactNumber;
  String dob;
  var address;
  String gender;
  String createdAt;
  String userType;
  String profileImage;

  UserInformations(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.mailId,
      this.authKey,
      this.contactNumber,
      this.dob,
      this.address,
      this.gender,
      this.createdAt,
      this.userType,
      this.profileImage});

  UserInformations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mailId = json['mailId'];
    authKey = json['authKey'];
    contactNumber = json['contactNumber'];
    dob = json['dob'];
    address = json['address'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    userType = json['userType'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mailId'] = this.mailId;
    data['authKey'] = this.authKey;
    data['contactNumber'] = this.contactNumber;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['createdAt'] = this.createdAt;
    data['userType'] = this.userType;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
