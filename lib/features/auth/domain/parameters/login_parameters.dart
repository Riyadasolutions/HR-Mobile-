import 'dart:io';

import 'package:base_app/base/presentation/component/inputs/country/countries.dart';
import 'package:base_app/core/constants/constants.dart';

class LoginParameters {
  String? _mobile;
  String? _email;
  String? _password;
  Country _mobileCountry;
  String? _fcmToken;
  String? _faceIdToken;
  String? _otp;

  LoginParameters({
    String? otp,
    String? fcmToken,
    String? faceIdToken,
    String? password,
    String? email,
    String? mobile,
    Country mobileCountry = Constants.initMobileCountry,
  })  : _mobile = mobile,
        _otp = otp,
        _email = email,
        _password = password,
        _faceIdToken = faceIdToken,
        _fcmToken = fcmToken,
        _mobileCountry = mobileCountry;


  Country get mobileCountry => _mobileCountry;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_email != null) data["email"] = _email;
    if (_password != null) data[ "password"] = _password;
    data["device_type"] = Platform.isIOS ? 'ios' : 'android';


    // if (_mobile != null) data["mobile"] = _mobile;
    // if (_fcmToken != null) data["device_token"] = _fcmToken;

    // data["country_code"] = _mobileCountry.dialCode;
    // data["mobile_code"] = _mobileCountry.code;
    // if(_otp!=null)data["otp_code"] = _otp;
    return data;
  }

  Map<String, dynamic> toFaceIdJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (_fcmToken != null) data["device_token"] = _fcmToken;
     data["face_token"] = _faceIdToken;

    data["device_type"] = Platform.isIOS ? 'ios' : 'android';

    return data;
  }

  factory LoginParameters.fromJson(Map<String, dynamic> json) =>
      LoginParameters(mobile: json['phone'] ?? '');

  setData({
    required String email,
    required String password,
    String? fcmToken,
  }) {
    _password = password;
    _email = email;
    _fcmToken = fcmToken;
  }

  set fcmToken(String value) => _fcmToken = value;
  set mobileCountry(Country value) => _mobileCountry = value;


  String? get otp => _otp;
  String? get mobile => _mobile;

  set otp(String? value) => _otp = value;
}
