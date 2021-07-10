import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Fcm {
  static Dio dio;

  static init() {
    dio = Dio();
    dio.options = BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/',
      receiveDataWhenStatusError: true,
    );
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAbWTAI-M:APA91bEqWm8TsReUqZW9Dd-ALKTWkmWMVvIJ3IhkzssjXPjm5IOySjkuvJo3ph-A6TKm0ws8kIUx7nTF2aPwIE2CJZ4nDd-ZdAo1zQUgEBx9Kr1dyyo5Cp7Nz6YDACoic4Bi3pwwu_-Y'
    };
  }

  static Future<Response> sendNotification({
    @required String token,
    @required String senderName,
    @required String message,
  }) async {
    return await dio.post(
      'fcm/send',
      data: {
        "to": token,
        "notification": {
          "title": "message from $senderName",
          "body": message,
          "sound": "default"
        },
        "android": {
          "priority": "HIGH",
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default",
            "default_sound": true,
            "default_vibrate_timings": true,
            "default_light_settings": true
          }
        },
        "data": {
          "name": "mahmoud",
          "id": "FxGCVQtM4DWYcHQ6Dkf8twNL4td2",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      },
    );
  }
}
