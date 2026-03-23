import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/entity/profile_entity.dart';
import 'package:base_app/features/common/domain/repository/profile_repo.dart';

class GetProfileUseCase{
  final ProfileRepository _repository;

  const GetProfileUseCase({
    required ProfileRepository repository,
  }) : _repository = repository;

  Future<ApiResult<ProfileEntity>> call() async => await _repository.getProfile();
}
