class HomeData {
  bool status;
  String message;
  UserProducts data;
  HomeData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserProducts.fromJson(json['data']) : null;
  }
}

class UserProducts {
  List<BannerData> banners = [];
  List<GetHomeProductData> products = [];
  UserProducts.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerData.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(GetHomeProductData.fromJson(element));
    });
  }
}

class BannerData {
  dynamic id;
  String image;
  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class GetHomeProductData {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;
  List images;
  bool inFavourite;
  bool inCart;

  GetHomeProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    inFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
