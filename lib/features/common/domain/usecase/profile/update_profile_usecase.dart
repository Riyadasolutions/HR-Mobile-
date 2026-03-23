import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/entity/profile_entity.dart';
import 'package:base_app/features/auth/domain/parameters/profile_parameters.dart';
import 'package:base_app/features/common/domain/repository/profile_repo.dart';

class UpdateProfileUseCase{
  final ProfileRepository _repository;

  const UpdateProfileUseCase({
    required ProfileRepository repository,
  }) : _repository = repository;

  Future<ApiResult<ProfileEntity>> call({required ProfileParameters parameters}) async => await _repository.updateProfile(parameters: parameters);
}
