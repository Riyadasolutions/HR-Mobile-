import 'package:base_app/base/presentation/component/inputs/country/countries.dart';
import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/core/notification/device_token.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/auth/domain/parameters/register_parameters.dart';
import 'package:base_app/features/auth/domain/usecase/local/save_data_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/register_usecase.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier{
  final _tag = 'RegisterViewModel';
  final RegisterUseCase _registerUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;

  RegisterViewModel({
    required RegisterUseCase registerUseCase,
    required SaveUserDataUseCase saveUserDataUseCase,
  })  : _registerUseCase = registerUseCase,
        _saveUserDataUseCase = saveUserDataUseCase;

  ///variables
  bool _isLoading = false;
  late RegisterParameters _parameters ;


  ///getters
  bool get isLoading => _isLoading;
  RegisterParameters get parameters => _parameters;

  init() async {
    _parameters = RegisterParameters();
    _isLoading = false;
  }

  ///On update/change
  onUpdateMobileCountryCode(Country value){_parameters.mobileCountry = value; notifyListeners();}

  ///colling api functions

  // login user and save user data
  Future<ApiResult> register({required String name,required String email,required String mobile,required String password}) async {
    String? fcmToken = await getDeviceToken();
    if(fcmToken == null)  return ApiResult.failure(ErrorModel(code: ErrorEnum.messRequestData, errorMessage: tr(LocaleKeys.error)));
    _parameters.setData(name: name,email: email, mobile: mobile, password: password, fcmToken: fcmToken);
    log(_tag, _parameters.toJson().toString());
    _isLoading = true;
    notifyListeners();
    ApiResult rpiResult = await _registerUseCase.call(parameters: _parameters);

    _isLoading = false;
    notifyListeners();

    return rpiResult;
  }




}