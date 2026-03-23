
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';
import 'package:base_app/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:flutter/widgets.dart';



class ResetPasswordViewModel with ChangeNotifier {


  final ResetPasswordUseCase _resetPasswordUseCase;


  ResetPasswordViewModel({
    required ResetPasswordUseCase resetPasswordUseCase,
  })  : _resetPasswordUseCase = resetPasswordUseCase;



  ///variables
  bool _isLoading = false;

  ///getters
  bool get isLoading => _isLoading;

  ///calling APIs Functions
  //reset password and save user data
  Future<ApiResult> resetPassword({required ForgetPasswordParameters parameters}) async {
    _isLoading = true;
    notifyListeners();
    ApiResult responseModel = await _resetPasswordUseCase.call(parameters: parameters);
    if (responseModel.isSuccess) {}

    _isLoading = false;
    notifyListeners();

    return responseModel;
  }
}
