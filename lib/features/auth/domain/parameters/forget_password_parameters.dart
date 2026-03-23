import 'dart:io';

import 'package:base_app/base/presentation/component/inputs/country/countries.dart';

import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/enums.dart';

class ForgetPasswordParameters {
  String? _mobile;
  String? _email;
  Country _mobileCountry;
  String? _password;
  String? _otp;
   String? _fcmToken;
  final AuthMethodTypes _authMethodTypes;

  ForgetPasswordParameters({
    String? mobile,
    String? password,
    String? fcmToken,
    String? email,
    String? otp,
    required AuthMethodTypes authMethodTypes,
    Country mobileCountry = Constants.initMobileCountry,
  })  :_otp = otp,
        _mobile = mobile,
        _email = email,
        _authMethodTypes = authMethodTypes,
        _mobileCountry = mobileCountry,
        _password = password,
        _fcmToken = fcmToken;
  void setMobileCountry(Country mobileCountry) => _mobileCountry = mobileCountry;

  String? get fcmToken => _fcmToken;
  String? get password => _password;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get otp => _otp;
  AuthMethodTypes get authMethodTypes => _authMethodTypes;
  Country get mobileCountry => _mobileCountry;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_email != null) data["identifier"] = _email;
    if (_mobile != null) data["mobile"] = _mobile;
    if (_fcmToken != null) data["device_token"] = _fcmToken;
    // data["device_type"] = Platform.isIOS ? 'ios' : 'android';
    //
    // data["country_code"] = _mobileCountry.dialCode;
    // data["phone_code"] = _mobileCountry.code;
    if (_otp != null) data['token'] = _otp;

    return data;
  }

  Map<String, dynamic> toResetPasswordJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['token'] = _otp;
    data['password'] = _password;
    data['password_confirmation'] = _password;
    data['email'] = _email;

    return data;
  }




  setMobile( String mobile) => _mobile = mobile;
  setEmail( String email) => _email = email;
  setOtp(String otp) => _otp = otp;
  setCountry(Country country) => _mobileCountry = country;
  setPassword({required String password}) {_password = password;}
  setFcmToken({required String fcmToken}) {_fcmToken = fcmToken;}

  copyWith(String mobile) => ForgetPasswordParameters(
      mobile: '+${_mobileCountry.dialCode}$_mobile',
      password: _password,
      fcmToken: _fcmToken,
      email: _email,
      otp: _otp,
      authMethodTypes: _authMethodTypes,
      mobileCountry: _mobileCountry);
}
