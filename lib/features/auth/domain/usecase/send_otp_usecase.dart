
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';

import 'package:base_app/features/auth/domain/repository/auth_repo.dart';



class SendOTPUseCase {


  final AuthRepository _repository;

  const SendOTPUseCase({
    required AuthRepository repository,
  }) : _repository = repository;


  Future<ApiResult> call({required ForgetPasswordParameters parameters}) async => await _repository.forgetPassword(parameters: parameters);



}
