class OfferListResponse {
  String status;
  String message;
  List<Histories> histories;

  OfferListResponse({this.status, this.message, this.histories});

  OfferListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['histories'] != null) {
      histories = new List<Histories>();
      json['histories'].forEach((v) {
        histories.add(new Histories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.histories != null) {
      data['histories'] = this.histories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Histories {
  String broadcastId;
  String broadcastCode;
  String productName;
  String shopId;
  String shopName;
  String categoryId;
  String categoryName;
  String subcategoryId;
  String broadcastType;
  String subcategoryName;
  String imageUrl;
  String expireDate;
  String price;
  String unit;
  String comments;
  String status;
  String createdAt;
  String updatedAt;
  String noOfLikes;

  Histories(
      {this.broadcastId,
      this.broadcastCode,
      this.productName,
      this.shopId,
      this.shopName,
      this.categoryId,
      this.categoryName,
      this.subcategoryId,
      this.broadcastType,
      this.subcategoryName,
      this.imageUrl,
      this.expireDate,
      this.price,
      this.unit,
      this.comments,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.noOfLikes});

  Histories.fromJson(Map<String, dynamic> json) {
    broadcastId = json['broadcastId'];
    broadcastCode = json['broadcastCode'];
    productName = json['productName'];
    shopId = json['shopId'];
    shopName = json['shopName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subcategoryId = json['subcategoryId'];
    broadcastType = json['broadcastType'];
    subcategoryName = json['subcategoryName'];
    imageUrl = json['imageUrl'];
    expireDate = json['expireDate'];
    price = json['price'];
    unit = json['unit'];
    comments = json['comments'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    noOfLikes = json['noOfLikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['broadcastId'] = this.broadcastId;
    data['broadcastCode'] = this.broadcastCode;
    data['productName'] = this.productName;
    data['shopId'] = this.shopId;
    data['shopName'] = this.shopName;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['subcategoryId'] = this.subcategoryId;
    data['broadcastType'] = this.broadcastType;
    data['subcategoryName'] = this.subcategoryName;
    data['imageUrl'] = this.imageUrl;
    data['expireDate'] = this.expireDate;
    data['price'] = this.price;
    data['unit'] = this.unit;
    data['comments'] = this.comments;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['noOfLikes'] = this.noOfLikes;
    return data;
  }
}
