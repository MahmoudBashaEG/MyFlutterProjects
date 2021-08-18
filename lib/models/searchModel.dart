class SearchData {
  List<SearchProductData> searchProducts = [];
  SearchData.fromJson(List<dynamic> json) {
    json.forEach((element) {
      searchProducts.add(SearchProductData.fromJson(element));
    });
  }
}

class SearchProductData {
  dynamic id;
  dynamic price;
  String image;
  String name;
  String description;
  List images;
  bool inFavorite;
  bool inCart;
  SearchProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
