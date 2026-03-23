import 'dart:convert';
import 'dart:io';

import 'package:base_app/core/notification/notification_type.dart';
import 'package:base_app/core/notification/push_notification_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class NotificationUtils {

  late NotificationDetails _platformChannelSpecifics;

  NotificationUtils({StyleInformation? styleInformation}) {
    _platformChannelSpecifics = NotificationDetails(
      android: getAndroidNotificationDetails(styleInformation: styleInformation),
      iOS: getIosNotificationDetails(styleInformation: styleInformation),
    );
  }

  getAndroidNotificationDetails({StyleInformation? styleInformation}) =>  AndroidNotificationDetails(
    '2075FD',
    'LocalNotificationChannel',
    channelDescription: 'MainChannel',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
    styleInformation: styleInformation,

  );
  getIosNotificationDetails({StyleInformation? styleInformation}) => const DarwinNotificationDetails(
          presentAlert: false,
          presentBadge: false,
          presentSound: false,
          // sound: "default"
  );
  // getIosNotificationDetails({StyleInformation? styleInformation}) => const IOSNotificationDetails(
  //   presentAlert: false,
  //   presentBadge: false,
  //   presentSound: false,
  // );

  NotificationDetails getNotificationSpecifics() => _platformChannelSpecifics;
  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title, String body, String orderID, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name',
      largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max, playSound: true,
      styleInformation: bigPictureStyleInformation, importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(id: 0, title: title, body: body, notificationDetails: platformChannelSpecifics, payload: orderID);
  }
  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }

  showFileDownloadNotification({String? path,required String fileLink}) async {
    // TODO open file on notification click
    var filename = "File";
   var flutterLocalNotificationsPlugin=  FlutterLocalNotificationsPlugin();
    // For iOS request permission first.
    if(Platform.isIOS) {
      await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true,);
    }

    if(path!=null && path.isNotEmpty) {
      var tokens = path.split('/');
      if(tokens.isNotEmpty) {
        filename = tokens.last;
      }
    }

    final payload = jsonEncode(PushNotificationModel(
        body: path,
        itemId: '0',
        notificationForeground: fileLink,
        itemType: NotificationHelper.kFileDownloaded.toString(),
        title: 'Download'));

    flutterLocalNotificationsPlugin.show(
        id: 0, title: "$filename تم تنزيل ", body: "", notificationDetails: _platformChannelSpecifics, payload: payload
    );

  }

  static Future<String> downloadAndSaveImage(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }



}