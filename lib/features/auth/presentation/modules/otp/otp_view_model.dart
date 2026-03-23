import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/core/notification/device_token.dart';
import 'package:base_app/features/auth/domain/entity/auth_entity.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';
import 'package:base_app/features/auth/domain/usecase/local/save_data_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/send_otp_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/verify_otp_code_usecase.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OTPViewModel with ChangeNotifier {

  final SaveUserDataUseCase _saveUserDataUseCase;
  final VerifyOtpCodeUseCase _checkOTPUseCase;
  final SendOTPUseCase _sendOTPUseCase;

  OTPViewModel({
    required SaveUserDataUseCase saveUserDataUseCase,
    required VerifyOtpCodeUseCase checkOTPUseCase,
    required SendOTPUseCase sendOTPUseCase,
  })  : _saveUserDataUseCase = saveUserDataUseCase,
        _checkOTPUseCase = checkOTPUseCase,
        _sendOTPUseCase = sendOTPUseCase;

  ///variables
  bool _isLoading = false;
  bool _isResendLoading = false;
  bool _isTimerDone = false;
  String? _error;

  ///getters
  bool get isLoading => _isLoading;
  bool get isResendLoading => _isResendLoading;
  bool get isTimerDone => _isTimerDone;
  String? get error => _error;

  init(){
    _isResendLoading = false;
    _isLoading = false;
  }

  setError(){_error=null;notifyListeners();}

  onTimerEnd(){
    _isTimerDone = true;
    notifyListeners();
  }
  /// call APIs
  //send phone to get code
  Future<ApiResult> reSendCode(bool notify,ForgetPasswordParameters parameters) async {
    _isResendLoading = true;
    if(notify)notifyListeners();
    ApiResult result = await _sendOTPUseCase.call(parameters: parameters);
    if (result.isSuccess) {_isTimerDone = false;}
    _isResendLoading = false;
    notifyListeners();
    return result;
  }


  //send phone to get code
  Future<ApiResult<AuthEntity>> checkOtpCode({required ForgetPasswordParameters parameters}) async {
    String? fcmToken = await getDeviceToken();
    if(fcmToken == null)  return ApiResult.failure(ErrorModel(code: ErrorEnum.messRequestData, errorMessage: tr(LocaleKeys.error)));
    parameters.setFcmToken(fcmToken: fcmToken);
    _isLoading = true;
    notifyListeners();
    ApiResult<AuthEntity> responseModel = await _checkOTPUseCase.call(parameters: parameters);
    if ( responseModel.isSuccess) {
      AuthEntity? entity = (responseModel as Success<AuthEntity>).data;
      kUser = entity?.user;
      String? token = entity?.token;
      if ((token??'').isNotEmpty) { await _saveUserDataUseCase.call(token: token!);
      }
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


}
