

import 'package:base_app/core/api_helper/api_result.dart';

import 'package:base_app/features/auth/domain/entity/auth_entity.dart';

import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';
import 'package:base_app/features/auth/domain/repository/auth_repo.dart';




class ResetPasswordUseCase {
  final AuthRepository _repository;

  ResetPasswordUseCase({
    required AuthRepository repository,
  }) : _repository = repository;


  Future<ApiResult<AuthEntity>> call({ required ForgetPasswordParameters parameters}) async => await _repository.resetPassword(parameters: parameters);


}
