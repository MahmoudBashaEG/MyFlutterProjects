import 'package:flutter_appp/models/ProductModel.dart';

class CategoryProductModel {
  bool status;
  String message;
  List<Product> categoryProducts = [];
  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    json['data']['data'].forEach((el) {
      categoryProducts.add(
        Product.fromJson(el),
      );
    });
  }
}
