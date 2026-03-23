
import 'package:base_app/base/data/model/base/response_model.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/core/notification/device_token.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/features/auth/domain/entity/profile_entity.dart';
import 'package:base_app/features/auth/domain/usecase/delete_account_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/clear_user_data_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/currency/get_currency_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/currency/save_currency_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/get_is_first_time_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/get_is_login_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/logout_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/update_fcm_token_usecase.dart';
import 'package:base_app/features/common/domain/usecase/profile/get_profile_usecase.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import 'package:base_app/core/utils/logger.dart';


class LocalAuthProvider with ChangeNotifier {
  final _tag='LocalAuthProvider';

  ///Use Cases
  final IsUserLoginUseCase _isUserLoginUseCase;
  final GetIsFirstTimeUseCase _getIsFirstTimeUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final ClearUserDataUseCase _clearUserDataUseCase;
  final LogoutUseCase _logoutUseCase;
  final UpdateFCMTokenUseCase _updateFCMTokenUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final SaveUserCurrencyUseCase _saveUserCurrencyUseCase;
  final GetUserCurrencyUseCase _getUserCurrencyUseCase;











  LocalAuthProvider({
    required GetIsFirstTimeUseCase getIsFirstTimeUseCase,
    required ClearUserDataUseCase clearUserDataUseCase,
    required IsUserLoginUseCase isUserLoginUseCase,
    required GetProfileUseCase getProfileUseCase,
    required UpdateFCMTokenUseCase updateFCMTokenUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
    required SaveUserCurrencyUseCase saveUserCurrencyUseCase,
    required GetUserCurrencyUseCase getUserCurrencyUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _getIsFirstTimeUseCase = getIsFirstTimeUseCase,
        _clearUserDataUseCase = clearUserDataUseCase,
        _deleteAccountUseCase = deleteAccountUseCase,
        _updateFCMTokenUseCase = updateFCMTokenUseCase,
        _saveUserCurrencyUseCase = saveUserCurrencyUseCase,
        _getUserCurrencyUseCase = getUserCurrencyUseCase,
        _logoutUseCase = logoutUseCase,
        _isUserLoginUseCase = isUserLoginUseCase,
        _getProfileUseCase = getProfileUseCase;

  ///Variables
  bool _isLogin =false;
  bool _loading = false;
  String? _error;

  ///Getters
  bool get isAuth => _isLogin;
  bool get loading => _loading;
  String? get error => _error;


  ///call APIs Functions
  Future<bool> isLogin() async {
    ApiResult responseModel = _isUserLoginUseCase.call();
    if (responseModel.isSuccess) {
      _isLogin = true;
      log('isLogin', 'true');

      ApiResult profileResponseModel = await getUserProfile();
      if(profileResponseModel.isSuccess)_updateFCMToken();
      if(profileResponseModel.isSuccess)getCurrency();


      return profileResponseModel.isSuccess;
    } else {
      deleteLocalData();
    }
    return responseModel.isSuccess;
  }

  Future<bool> isFirstTime() async {
    ApiResult responseModel =  _getIsFirstTimeUseCase.call();
    return responseModel.isSuccess;
  }

  Future<bool> logOut() async {
    ApiResult responseModel = await _logoutUseCase.call();
    // if (responseModel.isSuccess) {
      deleteLocalData();
      // FirebaseMessaging.instance.deleteToken();
      _isLogin = false ;
      kClearGlobalData();
      notifyListeners();
    // }
    return responseModel.isSuccess;
  }


  Future<bool> getCurrency() async {
    ResponseModel responseModel =  _getUserCurrencyUseCase.call();
    kUserCurrency = responseModel.data;
    notifyListeners();
    return responseModel.isSuccess;
  }
  Future<bool> saveCurrency(String symbol) async {
    ResponseModel responseModel =await  _saveUserCurrencyUseCase.call(symbol: symbol);
    if (responseModel.isSuccess) {kUserCurrency = symbol;}
    notifyListeners();
    return responseModel.isSuccess;
  }



  Future<bool> deleteLocalData() async {

    ApiResult responseModel = await _clearUserDataUseCase.call();
    if (responseModel.isSuccess) {
      // FirebaseMessaging.instance.deleteToken();
      _isLogin = false ;

      kClearGlobalData();
       notifyListeners();
    }
    return responseModel.isSuccess;
  }

  Future<ApiResult<ProfileEntity>> getUserProfile() async {
    log(_tag, 'getUser');
    notify(true, null);

    ApiResult<ProfileEntity> responseModel = await _getProfileUseCase.call();


    if (responseModel.isSuccess) {
      kUser = (responseModel as Success<ProfileEntity>).data;

      notify(false, null);
    } else {
      logOut();
      notify(false, (responseModel as Failure<ProfileEntity>).error.errorMessage);
    }

    log('getUserProfile', (kUser?.name??'').toString());
    return responseModel;
  }


  //update fcm token
  Future<bool> _updateFCMToken() async {

    String? fcmToken = await getDeviceToken();
    if(fcmToken==null)return false;
    ApiResult responseModel = await _updateFCMTokenUseCase.call(fcmToken: fcmToken);
    return responseModel.isSuccess;
  }

  ///update screens status Function
  void notify(bool loading, String? error) {
    _loading = loading;
    _error = error;
    notifyListeners();
  }


  //Delete Account
  Future<ApiResult> deleteAccount() async {
    log(_tag, 'deleteAccount');
    notify(true, null);
    ApiResult responseModel =await _deleteAccountUseCase.call();
    if (responseModel.isSuccess) {
      if (await deleteLocalData()) {
        notify(false, null);
      }  else{
        notify(false, tr(LocaleKeys.error));
      }


    }else{
      notify(false, (responseModel as Failure).error.errorMessage);
    }
    return responseModel;
  }
}
