class NotificationListResponse {
  String status;
  String message;
  List<OfferStores> offerStores;

  NotificationListResponse({this.status, this.message, this.offerStores});

  NotificationListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['offerStores'] != null) {
      offerStores = new List<OfferStores>();
      json['offerStores'].forEach((v) {
        offerStores.add(new OfferStores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.offerStores != null) {
      data['offerStores'] = this.offerStores.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferStores {
  String broadcastId;
  String broadcastCode;
  String broadcastType;
  String productName;
  String shopId;
  String shopName;
  String categoryId;
  String categoryName;
  String subcategoryId;
  String subcategoryName;
  String imageUrl;
  String expireDate;
  String price;
  String unitId;
  String unit;
  String comments;
  String status;
  var editBroadcastId;
  String republishedBroadcastId;
  String createdAt;
  String updatedAt;
  var viewedUserIds;
  String shopLogo;
  String offerCounts;
  String referenceCodeShareContent;
  String publishedDate;
  String isUserViewed;
  String shareContent;
  String isLiked;
  String noOfLikes;

  OfferStores(
      {this.broadcastId,
      this.broadcastCode,
      this.broadcastType,
      this.productName,
      this.shopId,
      this.shopName,
      this.categoryId,
      this.categoryName,
      this.subcategoryId,
      this.subcategoryName,
      this.imageUrl,
      this.expireDate,
      this.price,
      this.unitId,
      this.unit,
      this.comments,
      this.status,
      this.editBroadcastId,
      this.republishedBroadcastId,
      this.createdAt,
      this.updatedAt,
      this.viewedUserIds,
      this.shopLogo,
      this.offerCounts,
      this.referenceCodeShareContent,
      this.publishedDate,
      this.isUserViewed,
      this.shareContent,
      this.isLiked,
      this.noOfLikes});

  OfferStores.fromJson(Map<String, dynamic> json) {
    broadcastId = json['broadcastId'];
    broadcastCode = json['broadcastCode'];
    broadcastType = json['broadcastType'];
    productName = json['productName'];
    shopId = json['shopId'];
    shopName = json['shopName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subcategoryId = json['subcategoryId'];
    subcategoryName = json['subcategoryName'];
    imageUrl = json['imageUrl'];
    expireDate = json['expireDate'];
    price = json['price'];
    unitId = json['unitId'];
    unit = json['unit'];
    comments = json['comments'];
    status = json['status'];
    editBroadcastId = json['editBroadcastId'];
    republishedBroadcastId = json['republishedBroadcastId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    viewedUserIds = json['viewedUserIds'];
    shopLogo = json['shopLogo'];
    offerCounts = json['offerCounts'];
    referenceCodeShareContent = json['referenceCodeShareContent'];
    publishedDate = json['publishedDate'];
    isUserViewed = json['isUserViewed'];
    shareContent = json['shareContent'];
    isLiked = json['isLiked'];
    noOfLikes = json['noOfLikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['broadcastId'] = this.broadcastId;
    data['broadcastCode'] = this.broadcastCode;
    data['broadcastType'] = this.broadcastType;
    data['productName'] = this.productName;
    data['shopId'] = this.shopId;
    data['shopName'] = this.shopName;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['subcategoryId'] = this.subcategoryId;
    data['subcategoryName'] = this.subcategoryName;
    data['imageUrl'] = this.imageUrl;
    data['expireDate'] = this.expireDate;
    data['price'] = this.price;
    data['unitId'] = this.unitId;
    data['unit'] = this.unit;
    data['comments'] = this.comments;
    data['status'] = this.status;
    data['editBroadcastId'] = this.editBroadcastId;
    data['republishedBroadcastId'] = this.republishedBroadcastId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['viewedUserIds'] = this.viewedUserIds;
    data['shopLogo'] = this.shopLogo;
    data['offerCounts'] = this.offerCounts;
    data['referenceCodeShareContent'] = this.referenceCodeShareContent;
    data['publishedDate'] = this.publishedDate;
    data['isUserViewed'] = this.isUserViewed;
    data['shareContent'] = this.shareContent;
    data['isLiked'] = this.isLiked;
    data['noOfLikes'] = this.noOfLikes;
    return data;
  }
}
