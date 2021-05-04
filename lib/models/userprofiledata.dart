class UserProfileData {
  bool status;
  String message;
  UserProducts data;
  UserProfileData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserProducts.fromJson(json['data']) : null;
  }
}

class UserProducts {
  List<dynamic> banners;
  List<dynamic> products;
  String ad;
  UserProducts.fromJson(Map<String, dynamic> json) {
    banners = json['banners'];
    products = json['products'];
    ad = json['ad'];
  }
}
