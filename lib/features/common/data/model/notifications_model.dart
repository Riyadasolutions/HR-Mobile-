
import 'package:base_app/base/data/model/response/pagination_model.dart';
import 'package:base_app/base/domain/entities/pagination_list_entity.dart';
import 'package:base_app/features/common/data/model/notification_model.dart';
import 'package:base_app/features/common/domain/entity/notification_entity.dart';



class NotificationsModel {

  final PaginationModel _pagination;
  final List<NotificationModel> _list;

  PaginationListEntity<NotificationEntity> toEntity() => PaginationListEntity<NotificationEntity>(
    pagination: this._pagination.toEntity(),
    list: this._list.map((model) => model.toEntity()).toList(),
  );

  const NotificationsModel({
    required PaginationModel pagination,
    required List<NotificationModel> list,
  })  : _pagination = pagination,
        _list = list;

  factory NotificationsModel.fromJson(Map<String, dynamic>? json) => NotificationsModel(
    pagination: PaginationModel.fromJson(json??{}),
    list: List<NotificationModel>.from((json?["data"]??[]).map((x) => NotificationModel.fromJson(x))),
  );
}

