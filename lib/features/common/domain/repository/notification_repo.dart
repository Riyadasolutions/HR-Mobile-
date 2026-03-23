import 'package:base_app/base/data/model/base/api_response.dart';
import 'package:base_app/base/domain/entities/pagination_list_entity.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/entity/notification_entity.dart';

abstract class NotificationRepository {
  Future<ApiResult<PaginationListEntity<NotificationEntity>>> getNotifications ({required int page});
  Future<ApiResult<int>> getNotificationCount();
  Future<ApiResult> readNotification({required int notificationId});
}
