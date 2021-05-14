class UpdateFavoriteProducts {
  bool status;
  String message;
  UpdateFavoriteProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
