import 'dart:io';

import 'package:base_app/base/presentation/component/inputs/country/countries.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/features/auth/core/auth/auth_helper.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';



class RegisterParameters {
  String? _name;
  String? _email;
  String? _password;
  String? _fcmToken;
  final String? _deviceToken;
  String? _mobile;
  String? _subdomain;
  Country _mobileCountry;
  AuthMethodTypes _authMethodTypes;
  AuthType _authType;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    (_name ?? '').isNotEmpty ? data['name'] = _name : null;
    (_email ?? '').isNotEmpty ? data['email'] = _email : null;
    (_mobile ?? '').isNotEmpty ? data['phone'] = _mobile : null;
    (_password ?? '').isNotEmpty ? data['password'] = _password : null;
    (_password ?? '').isNotEmpty ? data['password_confirmation'] = _password : null;
    // (_subdomain ?? '').isNotEmpty ? data['subdomain'] = _subdomain : null;
    // (_fcmToken ?? '').isNotEmpty ? data['fcm_token'] = _fcmToken : null;


    data["phone_code"] = (_mobileCountry.code);
    data["phone_country_code"] = (_mobileCountry.code);

    // data["device_type"] = Platform.isIOS?'ios':'android';
    // data["device_token"] = _deviceToken;
    // data["guard"] = 'user';
    // if (_authType != AuthType.provider) data["provider"] = _authType.name;

    return data;
  }




  setData({required String name,required String email,required String mobile,required String password,required String? fcmToken}){
    _name = name;
    _email = email;
    _mobile = mobile;
    _fcmToken = fcmToken;
    _password = password;
  }

  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  Country get mobileCountry => _mobileCountry;

  String? get mobile => _mobile;
  AuthMethodTypes get authMethodTypes => _authMethodTypes;

  RegisterParameters({
    String? name,
    String? email,
    String? password,
    String? deviceToken,
    String? mobile,
    AuthMethodTypes? authMethodTypes,
    AuthType? authType,
    Country mobileCountry = Constants.initMobileCountry,
  })  :
        _name = name,
        _email = email,
        _password = password,
        _deviceToken = deviceToken,
        _authMethodTypes = authMethodTypes ??AuthMethodTypes.register,
        _mobile = mobile,
        _authType = authType??AuthType.provider,
        _mobileCountry = mobileCountry;

  static RegisterParameters init(ForgetPasswordParameters parameters) => RegisterParameters(
    mobile: parameters.mobile,
    email: parameters.email,
    password: parameters.password,
    mobileCountry: parameters.mobileCountry,
    authMethodTypes: parameters.authMethodTypes,
    // authType: parameters.authType,

  );

  set mobileCountry(Country value) {
    _mobileCountry = value;
  }
}
