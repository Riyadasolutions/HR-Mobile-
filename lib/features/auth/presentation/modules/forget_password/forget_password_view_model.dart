
import 'package:base_app/base/presentation/component/inputs/country/countries.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';
import 'package:base_app/features/auth/domain/usecase/send_otp_usecase.dart';
import 'package:flutter/widgets.dart';



class ForgetPasswordViewModel with ChangeNotifier {

  final SendOTPUseCase _sendOTPUseCase;

  ForgetPasswordViewModel({
    required SendOTPUseCase sendOTPUseCase,
  }) : _sendOTPUseCase = sendOTPUseCase;

  ///variables
  bool _isLoading = false;
  late ForgetPasswordParameters _parameters;


  ///getters
  bool get isLoading => _isLoading;
  ForgetPasswordParameters get parameters => _parameters;


  ///On update/change
  onUpdateMobileCountryCode(Country value){_parameters.setCountry(value) ; notifyListeners();}



  init(){
    _parameters =ForgetPasswordParameters(authMethodTypes: AuthMethodTypes.reset);
  }




  ///colling api functions
 // Forget password
 Future<ApiResult> forgetPassword({ required String email ,required String mobile}) async {
    _parameters.setMobile(mobile);
    _parameters.setEmail(email);


  _isLoading = true;
   notifyListeners();
    ApiResult responseModel = await _sendOTPUseCase.call(parameters: _parameters);
    if (responseModel.isSuccess) {
    }

    _isLoading = false;
    notifyListeners();

    return responseModel;
  }

}
