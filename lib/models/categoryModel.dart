class CategoryInformation {
  bool status;
  String message;
  List<Category> categories = [];
  CategoryInformation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    json['data']['data'].forEach((el) {
      categories.add(Category.fromJson(el));
    });
  }
}

class Category {
  String image;
  String name;
  dynamic id;
  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}
