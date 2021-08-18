import 'package:flutter_appp/models/ProductModel.dart';

class FavoriteProductsData {
  bool status;
  String message;
  List<Product> favoriteProducts = [];
  FavoriteProductsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    json['data']['data'].forEach((element) {
      favoriteProducts.add(Product.fromJson(element['product']));
    });
  }
}
