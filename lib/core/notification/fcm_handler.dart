import 'dart:convert';
import 'dart:io';

import 'package:base_app/core/utils/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'data/notification_data_model.dart';
import 'notification_type.dart';
import 'notification_utils.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
  playSound: true,
);

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
}

class FcmHandler extends StatefulWidget {
  final Widget _child;
  final GlobalKey<NavigatorState> _navigatorKey;

  const FcmHandler({
    Key? key,
    required Widget child,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _child = child,
        _navigatorKey = navigatorKey,
        super(key: key);

  @override
  _FcmHandlerState createState() => _FcmHandlerState();
}

class _FcmHandlerState extends State<FcmHandler> {
  static const _tag = 'FcmHandler';
  static bool initialized = false;

  @override
  void initState() {
    super.initState();
    if (!initialized) initializeFcm();
  }

  @override
  Widget build(BuildContext context) {
    return widget._child;
  }

  Future<void> initializeFcm() async {
    if (!initialized) {
      // Initialize Firebase
      await Firebase.initializeApp();

      // Set up background message handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // Initialize local notifications

      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_notification');

      final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();
      final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin,);
      await flutterLocalNotificationsPlugin.initialize(
        settings: initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      );
      // assign channel (required after android 8)
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
      // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

      // Request permissions for iOS
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true,);

      // Set foreground notification presentation options
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

      // Create notification channel for Android
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

      // Handle initial message
      final RemoteMessage? remoteMessage =
      await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        setupNotificationClickAction(json.encode(remoteMessage.data), widget._navigatorKey);
      }

      log(_tag, "Requesting FCM token...");
      _getToken();

      // Listen for foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log(_tag, 'FCM foreground message: ${message.data}\n notification - ${message.notification?.title ?? ''}');

        if (Platform.isAndroid /*|| Platform.isIOS*/) {
          flutterLocalNotificationsPlugin.show(
            id: 0,
            title: message.notification?.title ?? '',
            body: message.notification?.body ?? '',
            notificationDetails: NotificationUtils().getNotificationSpecifics(),
            payload: json.encode(message.data),
          );
        }
      });

      // Listen for message opened from terminated state
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log(_tag, 'onMessageOpenedApp Data:${message.data}');
        setupNotificationClickAction(
          json.encode(message.data),
          widget._navigatorKey,
        );
      });
    }
  }

  Future<void> _getToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      log(_tag, "FCM token: $token");
      initialized = true;
    } catch (e) {
      log(_tag, "FCM token error: $e");
    }
  }
  static void setupNotificationClickAction(String payload,GlobalKey<NavigatorState>? navigatorKey) {
    // handle firebase and local notification clicks here
    log(_tag,'NOTIFICATIONS, ${payload.toString()}');

    // FCMNotificationModel model = notificationModelFromJson(payload);
    NotificationPayload entity = NotificationPayload.fromJson(json.decode(payload));

    // log(_tag,'NOTIFICATIONS, ${data.toString()}');
    // String? itemType = data.type;
    // int? itemId = data.referenceId;

    NotificationHelper.notificationNav(entity,navigatorKey:  navigatorKey);

  }


  void onDidReceiveNotificationResponse(NotificationResponse response) {
    if (response.payload != null) {
      log(_tag, 'notification payload: ${response.payload}');
      setupNotificationClickAction(response.payload!, widget._navigatorKey);
    }
  }

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    if (payload != null) {
      log(_tag, 'notification payload iOS: $payload');
      setupNotificationClickAction(payload, widget._navigatorKey);
    }
  }
}












// import 'dart:convert';
// import 'dart:io';
//
//
// import 'package:base_app/core/notification/data/notification_data_model.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:base_app/core/notification/notification_type.dart';
// import 'package:base_app/core/utils/logger.dart';
//
// import 'notification_utils.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // titletion
//   importance: Importance.high,
// );
//
//
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//
// }
// class FcmHandler extends StatefulWidget {
//
//   final Widget _child;
//   final GlobalKey<NavigatorState>  _navigatorKey;
//
//   @override
//   _FcmHandlerState createState() => _FcmHandlerState();
//
//   const FcmHandler({super.key,
//     required Widget child,required GlobalKey<NavigatorState> navigatorKey,
//   })  : _child = child,_navigatorKey = navigatorKey;
// }
//
// class _FcmHandlerState extends State<FcmHandler> {
//  static const _tag = 'FcmHandler';
//
//
//   static bool initialized = false;
//
//   static const IOSNotificationDetails iosLiquidChannel = IOSNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true, sound: "default");
//
//
//
//   Future selectNotification(String? payload) async {
//     if (payload != null) {
//       log(_tag,'notification payload android: $payload');
//       setupNotificationClickAction(payload,widget._navigatorKey);
//     }
//   }
//
//   Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
//     if (payload != null) {
//       log(_tag,'notification payload android: $payload');
//       setupNotificationClickAction(payload,widget._navigatorKey);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     log('FcmHandler', 'initialized $initialized');
//     if (!initialized) initializeFcm();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget._child;
//   }
//
//   Future<void> initializeFcm() async {
//
//     if (!initialized) {
//       // initialize Firebase
//       await Firebase.initializeApp();
//       // initialize Firebase
//       FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//
//       const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//       final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//       final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS,);
//       await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification,);
//       await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true,sound:  true);/// NEW
//       await FirebaseMessaging.instance.requestPermission();/// NEW
//       // assign channel (required after android 8)
//       await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
//
//
//       ///init FirebaseMessaging
//       final RemoteMessage? remoteMessage =  await FirebaseMessaging.instance.getInitialMessage();
//       if (remoteMessage != null) {setupNotificationClickAction(json.encode(remoteMessage.data),widget._navigatorKey);}
//
//
//
//       log(_tag,"Requesting FCM token...");
//
//
//       _getToken();
//
//
//     /// onMessage
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
//       log(_tag,'FCM foreground message: ${message.data}\n notification - ${message.notification?.title ?? ''}');
//       log(_tag,'FCM foreground message: ${message.data}\n <notification - ${message.notification?.body}>');
//       log(_tag,'FCM foreground message: ${message.data}\n <notification image- ${message.notification?.android?.imageUrl}>');
//       log(_tag,'FCM foreground message: ${message.data}\n <notification image- ${message.notification?.apple?.imageUrl}>');
//
//       StyleInformation? styleInformation;
//       if (message.notification?.android?.imageUrl != null) {
//         final bigPicturePath = await NotificationUtils.downloadAndSaveImage(message.notification!.android!.imageUrl!, "fileName");
//         styleInformation = BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath));
//       } else if (message.notification?.apple?.imageUrl != null) {
//
//         final bigPicturePath = await NotificationUtils.downloadAndSaveImage(message.notification!.apple!.imageUrl!, "fileName");
//       styleInformation = BigPictureStyleInformation(
//           FilePathAndroidBitmap(bigPicturePath)
//       );
//     }
//
//       if (Platform.isAndroid) {
//         flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification?.title,
//           message.notification?.body,
//
//           // message.data['title'],
//           // message.data['body'],
//           NotificationUtils(styleInformation: styleInformation).getNotificationSpecifics(),
//           payload: json.encode(message.data),
//         );
//       } else if (Platform.isIOS) {
//         flutterLocalNotificationsPlugin.show(
//           0,
//           // message.data['title'],
//           // message.data['body'],
//           message.notification?.title,
//           message.notification?.body,
//           const NotificationDetails(iOS: iosLiquidChannel),
//           payload: json.encode(message.data),
//         );
//       }
//     });
//
//
//     ///onMessageOpenedApp
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       log(_tag, 'onMessageOpenedApp Data:${message.data}');
//       setupNotificationClickAction(json.encode(message.data),widget._navigatorKey);
//     });
//
//
//   }
//   }
//
//
//  Future<void> _getToken() async {
//    try {
//      String? token = await FirebaseMessaging.instance.getToken();
//      log(_tag, "FCM token: $token");
//      initialized = true;
//    } catch (e) {
//      log(_tag, "FCM token error: $e");
//    }
//  }
//
//
//  static void setupNotificationClickAction(String payload,GlobalKey<NavigatorState>? navigatorKey) {
//     // handle firebase and local notification clicks here
//     log(_tag,'NOTIFICATIONS, ${payload.toString()}');
//
//     // FCMNotificationModel model = notificationModelFromJson(payload);
//     NotificationPayload entity = NotificationPayload.fromJson(json.decode(payload));
//
//     // log(_tag,'NOTIFICATIONS, ${data.toString()}');
//     // String? itemType = data.type;
//     // int? itemId = data.referenceId;
//
//     NotificationHelper.notificationNav(entity,navigatorKey:  navigatorKey);
//
//   }
//
//   void openDownloadedFile(String path) async {
//     // final _result = await OpenFile.open(path);
//     // print('${_result.message} >> ${_result.type.index}');
//
//     // if (_result.type.index != 0) {
//     //   showCustomSnackBar( _result.message,context);
//     // }
//   }
// }