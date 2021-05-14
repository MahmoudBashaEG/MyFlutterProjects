class FavoriteProductsData {
  bool status;
  String message;
  List<ProductData> favoriteProducts = [];
  FavoriteProductsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    json['data']['data'].forEach((element) {
      favoriteProducts.add(ProductData.fromJson(element['product']));
    });
  }
}

class ProductData {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;
  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
