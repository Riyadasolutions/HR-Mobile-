import 'package:base_app/core/notification/data/notification_data_model.dart';
import 'package:base_app/features/common/domain/entity/notification_entity.dart';

// ignore: must_be_immutable
class NotificationModel {

  final String _id;
  final int _userId;
  final String _title;
  final String _body;
  final NotificationPayload _payload;
  final String _createdAt;
  final bool _isRead;

  NotificationEntity toEntity() => NotificationEntity(
    id: this._id,
    userId: this._userId,
    title: this._title,
    body: this._body,
    payload: this._payload,
    createdAt: this._createdAt,
    isRead: this._isRead,
  );

   NotificationModel({
    required String id,
    required int userId,
    required String title,
    required String body,
    required NotificationPayload payload,
    required String createdAt,
    required bool isRead,
  })  : _id = id,
        _userId = userId,
        _title = title,
        _body = body,
        _payload = payload,
        _createdAt = createdAt,
        _isRead = isRead;

// 

  factory NotificationModel.fromJson(Map<String, dynamic>? json) =>
      NotificationModel(
        id: json?["id"] ?? '',
        userId: json?["user_id"]?? 0,
        title: json?["title"]??'',
        body: json?["body"]??'',
        createdAt: json?["created_at"]??'',
        payload: NotificationPayload.fromJson(json?["data"]),
        isRead: (json?["is_read"]??0).toString()=='1',
      );
}
