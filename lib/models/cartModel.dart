class CartProductsData {
  bool status;
  String message;
  List<ProductData> cartProducts = [];
  CartProductsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    print(json['data']['cart_items']);
    print(
        '------------------------------------------------------------------------------------------------');
    json['data']['cart_items'].forEach((element) {
      print(element['product']);
      cartProducts.add(ProductData.fromJson(element['product']));
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
  bool inFavorite;
  bool inCart;
  List<String> images;
  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
  }
  ProductData({
    this.price,
    this.oldPrice,
  });
}
