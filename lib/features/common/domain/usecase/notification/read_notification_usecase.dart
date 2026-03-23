import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/repository/notification_repo.dart';


class ReadNotificationUseCase{

  final NotificationRepository _repository;

  const ReadNotificationUseCase({
    required NotificationRepository repository,
  }) : _repository = repository;

  Future<ApiResult> call({required int notificationId}) async => await _repository.readNotification(notificationId: notificationId);





}
