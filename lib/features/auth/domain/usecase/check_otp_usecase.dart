import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/entity/auth_entity.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';
import 'package:base_app/features/auth/domain/repository/auth_repo.dart';


class CheckOTPUseCase  {
  final AuthRepository _repository;

  CheckOTPUseCase({
    required AuthRepository repository,
  }) : _repository = repository;

  Future<ApiResult<AuthEntity>> call({ required ForgetPasswordParameters parameters}) async => await _repository.checkOtpCode(parameters: parameters);

// Future<ResponseModel> call({required ForgetPasswordParameters parameters}) async =>
  //     BaseUseCaseCall.onGetData<AuthEntity>(await _repository.checkOtpCode(parameters:parameters), onConvert,tag: 'UserCheckOTPUseCase');
  // @override
  // ResponseModel<AuthEntity> onConvert(BaseModel baseModel) {
  //   String? token = (baseModel.responseData['token']??'').toString();
  //   if (token.isNotEmpty) {
  //     AuthEntity entity = AuthModel.fromJson(baseModel.responseData);
  //     return ResponseModel(true, baseModel.message, data: entity);
  //   } else {
  //     return ApiChecker.checkApi(message: baseModel.message);
  //   }
  // }
}
