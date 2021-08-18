import 'package:flutter_appp/models/ProductModel.dart';

class CartProductsData {
  bool status;
  String message;
  dynamic total;
  List<Product> cartProducts = [];
  CartProductsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['data']['total'];
    print(total);
    json['data']['cart_items'].forEach((element) {
      cartProducts.add(Product.fromJson(element['product']));
    });
  }
}
