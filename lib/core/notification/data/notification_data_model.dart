import 'dart:convert';

import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/core/utils/converters/enum_converter.dart';

// NotificationType getNotificationTypeByKey(String type){
//   switch(type){
//     // case"transaction": return NotificationType.transaction;
//     // case"promotion": return NotificationType.promotion;
//     // case"shop_admin": return NotificationType.order;
//
//
//     default: return NotificationType.booking;
//   }
// }


class NotificationPayload  {
  final int _id;
  final NotificationType _type;
  final Map<String, dynamic>? _data;

  factory NotificationPayload.fromJson(Map<String, dynamic>? json) =>
      NotificationPayload(
        id: int.tryParse((json?["id"]??json?["action_id"]??'0').toString())??0,
        data: json?["data"]==null?null:jsonDecode(json?["data"]),
        type: NotificationType.values.fromValue(json?["action_type"] ?? ''),
        // app: kGetAccountTypeEnum(json?["app"] ?? ''),
      );



  NotificationType get type => _type;


  int get id => _id;

  Map<String, dynamic>? get data => _data;

  const NotificationPayload({
    required int id,
    required NotificationType type,
    required Map<String, dynamic>? data,
  })  : _id = id,
        _type = type,
        _data = data;
}
