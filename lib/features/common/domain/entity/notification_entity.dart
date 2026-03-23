import 'dart:ui';

import 'package:base_app/core/notification/data/notification_data_model.dart';
import 'package:equatable/equatable.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class NotificationEntity extends Equatable {
  final String _id;
  final int _userId;
  final String _title;
  final String _body;
  final String _createdAt;
  // final Color _color =  Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  final NotificationPayload _payload;
   bool _isRead;

  @override
  List<Object> get props => [
        _id,
        _userId,
        _title,
        _body,
        _payload,
        _isRead,
      ];

   NotificationEntity({
    required String id,
    required int userId,
    required String createdAt,
    required String title,
    required String body,
    required NotificationPayload payload,
    required bool isRead,
  })  : _id = id,
        _userId = userId,
        _title = title,
        _createdAt = createdAt,
        _body = body,
        _payload = payload,
        _isRead = isRead;

  bool get isRead => _isRead;

  NotificationPayload get payload => _payload;

  String get body => _body;

  String get title => _title;
  String get createdAt => _createdAt;

  int get userId => _userId;

  String get id => _id;

  // Color get color => _color;
  readNotification()=>_isRead= true;
}
