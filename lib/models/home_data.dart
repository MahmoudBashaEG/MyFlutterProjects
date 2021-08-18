import 'package:flutter_appp/models/ProductModel.dart';

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
  List<Product> products = [];
  UserProducts.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerData.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(Product.fromJson(element));
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
