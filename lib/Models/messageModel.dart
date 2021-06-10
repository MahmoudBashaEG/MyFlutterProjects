class MessageData {
  String text;
  String senderId;
  String time;
  String receiverId;

  MessageData({
    this.text,
    this.time,
    this.receiverId,
    this.senderId,
  });
  MessageData.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    time = json['time'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
  }

  Map<String, dynamic> getMap() {
    return {
      'text': text,
      'time': time,
      'receiverId': receiverId,
      'senderId': senderId,
    };
  }
}
