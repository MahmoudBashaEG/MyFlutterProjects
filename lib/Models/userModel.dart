class UserData {
  String name;
  String email;
  String uid;
  String cover;
  String photo;
  String bio;
  String mobileToken;
  dynamic phone;
  bool isVerified;

  UserData({
    this.name,
    this.email,
    this.uid,
    this.cover,
    this.photo,
    this.mobileToken,
    this.bio,
    this.phone,
    this.isVerified,
  });
  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    cover = json['cover'];
    photo = json['photo'];
    bio = json['bio'];
    phone = json['phone'];
    mobileToken = json['mobileToken'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> getMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'phone': phone,
      'isVerified': isVerified,
      'cover': cover,
      'bio': bio,
      'photo': photo,
      'mobileToken': mobileToken,
    };
  }
}
