class CategoryListResponse {
  String status;
  String message;
  CategoryAllList categoryAllList;
  SubcategoryAllList subcategoryAllList;
  List<CategoryList> categoryList;

  CategoryListResponse(
      {this.status,
      this.message,
      this.categoryAllList,
      this.subcategoryAllList,
      this.categoryList});

  CategoryListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    categoryAllList = json['categoryAllList'] != null
        ? new CategoryAllList.fromJson(json['categoryAllList'])
        : null;
    subcategoryAllList = json['subcategoryAllList'] != null
        ? new SubcategoryAllList.fromJson(json['subcategoryAllList'])
        : null;
    if (json['CategoryList'] != null) {
      categoryList = new List<CategoryList>();
      json['CategoryList'].forEach((v) {
        categoryList.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.categoryAllList != null) {
      data['categoryAllList'] = this.categoryAllList.toJson();
    }
    if (this.subcategoryAllList != null) {
      data['subcategoryAllList'] = this.subcategoryAllList.toJson();
    }
    if (this.categoryList != null) {
      data['CategoryList'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryAllList {
  String s1;

  CategoryAllList({this.s1});

  CategoryAllList.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    return data;
  }
}

class SubcategoryAllList {
  String s1;
  String s4;
  String s5;
  String s6;
  String s7;

  SubcategoryAllList({this.s1, this.s4, this.s5, this.s6, this.s7});

  SubcategoryAllList.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s4 = json['4'];
    s5 = json['5'];
    s6 = json['6'];
    s7 = json['7'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['4'] = this.s4;
    data['5'] = this.s5;
    data['6'] = this.s6;
    data['7'] = this.s7;
    return data;
  }
}

class CategoryList {
  String categoryId;
  String categoryName;
  String createdAt;
  String updatedAt;
  List<SubCategories> subCategories;

  CategoryList(
      {this.categoryId,
      this.categoryName,
      this.createdAt,
      this.updatedAt,
      this.subCategories});

  CategoryList.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['subCategories'] != null) {
      subCategories = new List<SubCategories>();
      json['subCategories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  String subCategeoryId;
  String subCategoryName;

  SubCategories({this.subCategeoryId, this.subCategoryName});

  SubCategories.fromJson(Map<String, dynamic> json) {
    subCategeoryId = json['subCategeoryId'];
    subCategoryName = json['subCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCategeoryId'] = this.subCategeoryId;
    data['subCategoryName'] = this.subCategoryName;
    return data;
  }
}
