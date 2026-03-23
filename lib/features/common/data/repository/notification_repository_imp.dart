import 'dart:async';

import 'package:base_app/base/data/model/base/base_model.dart';
import 'package:base_app/base/data/datasource/remote/dio/dio_client.dart';
import 'package:base_app/core/api_helper/api_error_handler_new.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/base/domain/entities/pagination_list_entity.dart';
import 'package:base_app/features/common/data/model/notifications_model.dart';
import 'package:base_app/features/common/domain/entity/notification_entity.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/notification_repo.dart';
import '../urls.dart';

class NotificationRepositoryImp implements NotificationRepository{
  final DioClient _dioClient;


  NotificationRepositoryImp({
    required DioClient dioClient,
  })
      : _dioClient = dioClient;

  @override
  Future<ApiResult<PaginationListEntity<NotificationEntity>>> getNotifications ({required int page}) async {
    try {
      Response response = await _dioClient.get(CommonURLs.kGetNotificationURL,queryParameters: {'page':page});
      BaseModel baseModel = BaseModel.fromJson(response.data);
      PaginationListEntity<NotificationEntity> entity = NotificationsModel.fromJson(baseModel.response).toEntity();
      return ApiResult.success(entity);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }


  @override
  Future<ApiResult<int>> getNotificationCount () async {
    try {
      Response response = await _dioClient.get(CommonURLs.kGetNotificationCountURL);
      BaseModel baseModel = BaseModel.fromJson(response.data);
      int? count = int.tryParse(baseModel.response??'0')??0;
      return ApiResult.success(count);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

  @override
  Future<ApiResult> readNotification({required int notificationId}) async {
    try {
      await _dioClient.post('${CommonURLs.kReadNotificationURL}/$notificationId');
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }


}
