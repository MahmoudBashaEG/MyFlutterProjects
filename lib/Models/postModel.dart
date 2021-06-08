class PostDate {
  String text;
  String name;
  String profileImage;
  String postImage;
  var date;
  String uid;
  PostDate({
    this.text,
    this.name,
    this.uid,
    this.date,
    this.profileImage,
    this.postImage,
  });
  PostDate.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    name = json['name'];
    uid = json['uid'];
    date = json['date'];
    profileImage = json['profileImage'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'name': name,
      'uid': uid,
      'date': date,
      'profileImage': profileImage,
      'postImage': postImage,
    };
  }
}
