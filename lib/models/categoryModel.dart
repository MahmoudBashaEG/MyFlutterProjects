class CategoryInformation {
  bool status;
  String message;
  CategoryInformationData data;
  CategoryInformation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? CategoryInformationData.fromJson(json['data'])
        : null;
  }
}

class CategoryInformationData {
  int currentPage;
  List data;
  CategoryInformationData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = json['data'];
  }
}
