import 'package:flutter_appp/models/home_data.dart';

class FavoriteData {
  List<GetFavoriteProductData> favoriteProducts = [];
  FavoriteData.fromJson(List<dynamic> json) {
    json.forEach((element) {
      favoriteProducts.add(GetFavoriteProductData.fromJson(element['product']));
    });
  }
}

class GetFavoriteProductData {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;
  GetFavoriteProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
