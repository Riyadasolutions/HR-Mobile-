

import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/entity/auth_entity.dart';
import 'package:base_app/features/auth/domain/parameters/register_parameters.dart';
import 'package:base_app/features/auth/domain/repository/auth_repo.dart';


class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase({
    required AuthRepository repository,
  }) : _repository = repository;

  Future<ApiResult<AuthEntity>> call({ required RegisterParameters parameters}) async => await _repository.register(parameters: parameters);

  // Future<ResponseModel<AuthEntity>> call({ required  RegisterParameters parameters}) async =>
  //     BaseUseCaseCall.onGetData<AuthEntity>( await _repository.register(parameters: parameters), onConvert,tag: 'RegisterUseCase',showError: true);
  //
  //
  // @override
  // ResponseModel<AuthEntity> onConvert(BaseModel baseModel) {
  //   try {
  //     String? accessToken = baseModel.responseData['token'];
  //     if (accessToken != null) {
  //       AuthEntity? entity = AuthModel.fromJson(baseModel.responseData);
  //       return ResponseModel(true, baseModel.message, data: entity);
  //     } else {
  //       return ResponseModel(true, baseModel.message);
  //     }
  //   } catch (e) {
  //     return ResponseModel(true, baseModel.message);
  //   }
  // }
}
