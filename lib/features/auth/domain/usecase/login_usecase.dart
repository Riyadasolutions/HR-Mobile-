

import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/entity/auth_entity.dart';
import 'package:base_app/features/auth/domain/parameters/login_parameters.dart';
import 'package:base_app/features/auth/domain/repository/auth_repo.dart';


class LoginUseCase{
  final AuthRepository _repository;
  LoginUseCase({required AuthRepository repository}) : _repository = repository;

  Future<ApiResult<AuthEntity>> call({ required LoginParameters parameters}) async => await _repository.login(parameters: parameters);


}
