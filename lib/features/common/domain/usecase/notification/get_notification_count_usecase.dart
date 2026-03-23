import 'package:base_app/core/api_helper/api_constant.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/repository/notification_repo.dart';


class GetNotificationCountUseCase{

  final NotificationRepository _repository;

  const GetNotificationCountUseCase({
    required NotificationRepository repository,
  }) : _repository = repository;

  Future<ApiResult<int>> call() async => await _repository.getNotificationCount();




}
