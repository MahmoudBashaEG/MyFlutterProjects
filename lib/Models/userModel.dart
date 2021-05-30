class UserData {
  String name;
  String email;
  String uid;
  dynamic phone;
  bool isVerified;

  UserData({
    this.name,
    this.email,
    this.uid,
    this.phone,
    this.isVerified,
  });
  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    phone = json['phone'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> getMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'phone': phone,
      'isVerified': isVerified,
    };
  }
}
