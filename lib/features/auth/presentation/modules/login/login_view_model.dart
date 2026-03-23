import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/base/presentation/component/inputs/country/countries.dart';
import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/core/notification/device_token.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/auth/core/auth/auth_helper.dart';
import 'package:base_app/features/auth/domain/entity/auth_entity.dart';
import 'package:base_app/features/auth/domain/parameters/login_parameters.dart';
import 'package:base_app/features/auth/domain/parameters/social_signIn_parameters.dart';
import 'package:base_app/features/auth/domain/usecase/local/save_data_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier{
  final _tag = 'LoginViewModel';
  final LoginUseCase _loginUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;

  LoginViewModel({
    required LoginUseCase loginUseCase,
    required SaveUserDataUseCase saveUserDataUseCase,
  })  : _loginUseCase = loginUseCase,
        _saveUserDataUseCase = saveUserDataUseCase;

  ///variables
  bool _isLoading = false;
  late LoginParameters _parameters ;


  ///getters
  bool get isLoading => _isLoading;
  LoginParameters get parameters => _parameters;

  init() async {
    _parameters = LoginParameters();
    _isLoading = false;
  }

  ///On update/change
  onUpdateMobileCountryCode(Country value){_parameters.mobileCountry = value; notifyListeners();}

  ///colling api functions

  // login user and save user data
  Future<ApiResult> login({required String email,required String password,String? fcmToken}) async {
    // String? fcmToken = await getDeviceToken();
    // if(fcmToken == null)  return ApiResult.failure(ErrorModel(code: ErrorEnum.messRequestData, errorMessage: tr(LocaleKeys.error)));
    _parameters.setData(email: email,password: password);
    log(_tag, _parameters.toJson().toString());
    _isLoading = true;
    notifyListeners();
    ApiResult rpiResult = await _loginUseCase.call(parameters: _parameters);
    if (rpiResult.isSuccess && rpiResult.data != null) {
      AuthEntity authEntity = rpiResult.data!;

      kUser = authEntity.user;
      String? token = authEntity.token;
      if (token.isNotEmpty) { await _saveUserDataUseCase.call(token: authEntity.token);}
    }


    _isLoading = false;
    notifyListeners();

    return rpiResult;
  }

  Future<ApiResult?> socialSignIn(BuildContext context, AuthType authType) async {
    SocialSignInParameters? parameters = await AuthHelper.auth(context, authType: authType);
    if(parameters == null)  return ApiResult.failure(ErrorModel(code: ErrorEnum.messRequestData, errorMessage: tr(LocaleKeys.error)));

    return await _socialSignIn( parameters: parameters);
  }


  Future<ApiResult> _socialSignIn({required SocialSignInParameters parameters}) async {
    log(_tag, '_socialSignIn ');
    String? fcmToken = await getDeviceToken();
    if(fcmToken == null)  return ApiResult.failure(ErrorModel(code: ErrorEnum.messRequestData, errorMessage: tr(LocaleKeys.error)));

    parameters.setFcmToken(fcmToken);

    _isLoading = true;
    notifyListeners();

    //
    // ResponseModel<AuthEntity> responseModel = await _socialLoginUseCase.call(parameters: parameters);
    //
    // log(_tag, '_socialSignIn token = ${responseModel.data}');
    // if (responseModel.isSuccess) {
    //   log(_tag, '_socialSignIn isSuccess');
    //   AuthEntity authEntity = responseModel.data!;
    //   kUser = authEntity.user;
    //   kUserType = _parameters.userType;
    //   String? token = authEntity.token;
    //   if (token.isNotEmpty) { await _saveUserDataUseCase.call(token: authEntity.token,userType: _parameters.userType);}
    //
    // }else{
    //   log(_tag, '_socialSignIn isFalse');
    //
    // }
    _isLoading = false;
    notifyListeners();
    return ApiResult.success(null);
  }








}