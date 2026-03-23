import 'package:base_app/core/utils/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

 String? kDeviceToken ;

Future<String?> getDeviceToken() async {
  if(kDeviceToken != null) {
    log("FCM token:", "$kDeviceToken");
    return kDeviceToken;
  }
  try {
    // FirebaseMessaging.instance.deleteToken();
    kDeviceToken = await FirebaseMessaging.instance.getToken();
    log("FCM token:", "$kDeviceToken");

    return kDeviceToken;
  } catch (e) {
    log("FCM token error:", " $e");
    return null;
  }
}
