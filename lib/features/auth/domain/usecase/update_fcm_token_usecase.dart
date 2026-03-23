import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/repository/auth_repo.dart';

class UpdateFCMTokenUseCase{


  final AuthRepository _repository;

  const UpdateFCMTokenUseCase({
    required AuthRepository repository,
  }) : _repository = repository;

  Future<ApiResult> call({required String fcmToken}) async => await _repository.fcmTokenUpdate(fcmToken: fcmToken);

}
