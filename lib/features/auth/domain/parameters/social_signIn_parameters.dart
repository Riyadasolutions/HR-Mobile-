import 'dart:io';

import 'package:base_app/features/auth/core/auth/auth_helper.dart';


class SocialSignInParameters {
  final String? _userId;
  final String? _email;
  final String? _name;
  final String? _image;
  // final String? _mobile;
  String? _fcmToken;
  final AuthType _authType;
  final String? _token;

  SocialSignInParameters({
    required String? userId,
    required String? email,
    required String? name,
    required String? image,
    required AuthType authType,
    String? fcmToken,
    String? token,
  })  :
        _userId = userId,
        _email = email,
        _fcmToken = fcmToken,
        _authType = authType,
        _name = name,
        _image = image,
        _token = token;

  setFcmToken(String? fcmToken){
    _fcmToken = fcmToken;
  }

  String? get image => _image;

  String? get name => _name;

  String? get email => _email;

  String? get userId => _userId;

  AuthType get authType => _authType;

  String? get token => _token;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      "provider_name": _authType.name,
      "social_id": _userId,
      "email": _email,
      "image": _image,
      "first_name": (_name??'').split(' ').first,
      "last_name": (_name??'').split(' ').last,
      "fcm_token": _fcmToken,
      "device_token": _fcmToken,
      "device_type": Platform.isIOS?'ios':'android',
      "token": _token,
    };
    // if (mobile.isNotEmpty) request.fields["mobile"] = mobile;   request.fields["email"] = email;

/*
    if (mobile.isNotEmpty) request.fields["mobile"] = mobile;   request.fields["email"] = email;
    if (subdomain.isNotEmpty) request.fields["subdomain"] = subdomain;
    if (phone_code.isNotEmpty) request.fields["phone_code"] = phone_code;
    request.fields["guard"] = "user";
    request.fields["provider"] = "google";

    request.headers["Accept"] = "application/json";
    request.headers["Content-Type"] = "application/json";
    request.headers["Accept-Language"] = "ar";
*/
    return data;
  }
}