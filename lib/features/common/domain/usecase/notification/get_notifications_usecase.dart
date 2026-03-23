import 'package:base_app/base/domain/entities/pagination_list_entity.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/entity/notification_entity.dart';
import 'package:base_app/features/common/domain/repository/notification_repo.dart';

class GetNotificationsUseCase{

  final NotificationRepository _repository;

  const GetNotificationsUseCase({
    required NotificationRepository repository,
  }) : _repository = repository;

  Future<ApiResult<PaginationListEntity<NotificationEntity>>> call({required int page}) async => await _repository.getNotifications(page: page);

}

