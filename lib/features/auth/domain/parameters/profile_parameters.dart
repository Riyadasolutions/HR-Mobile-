import 'dart:io';

import 'package:base_app/base/presentation/component/inputs/country/countries.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/core/constants/globals.dart';




class ProfileParameters {
  String? _dateOfBirth;
  String? _image;

  String? _name;
  String? _email;
  GenderType _gender;
  final String? _deviceToken;
  String? _mobile;
  bool _isNotificationEnabled;
  Country _mobileCountry;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    (_name ?? '').isNotEmpty ? data['name'] = _name : null;
    (_email ?? '').isNotEmpty ? data['email'] = _email : null;
    (_mobile ?? '').isNotEmpty ? data['phone'] = _mobile : null;
    // (_dateOfBirth ?? '').isNotEmpty ? data['date_of_birth'] = _dateOfBirth : null;

    // data["gender"] = _gender == GenderType.male ? 'male' : 'female';

    data["device_type"] = Platform.isIOS ? 'ios' : 'android';
    data["device_token"] = _deviceToken;
    data["mobile_code"] = (_mobileCountry.code);
    // data["notification"] = _isNotificationEnabled?1:0;

    return data;
  }

  static ProfileParameters initUser() =>
      ProfileParameters(userName: kUser?.name,
          name:  kUser?.name,
          email:  kUser?.email,
        image:  kUser?.image,
          gender: kGetGenderTypeByKey(kUser?.gender??'male') ,
          mobile:  kUser?.mobile,
          dateOfBirth:  kUser?.dateOfBirth,
          isNotificationEnabled:  false,
          mobileCountry: countries.firstWhere((item) => item.dialCode == (kUser?.mobileCode ?? 'SAR'), orElse: () => Constants.initMobileCountry),

      );


  void setLang(String dateOfBirth) => _dateOfBirth = dateOfBirth;
  void setGender(GenderType gender) => _gender = gender;
  void setIsNotificationEnabled(bool enable) => _isNotificationEnabled = enable;
  void setMobileCountry(Country mobileCountry) => _mobileCountry = mobileCountry;

  setData({required String email,required String mobile,required String name}){
    _name = name;
    _email = email;
    _mobile = mobile;


  }

  ProfileParameters({
   String? userName,
   String? name,
   String? email,
   String? image,
   GenderType? gender,
   String? deviceToken,
   String? mobile,
   Country mobileCountry = Constants.initMobileCountry,
    String? dateOfBirth,
    required bool isNotificationEnabled,
  })  : _dateOfBirth = dateOfBirth,
        _name = name,
        _email = email,
        _image = image,
        _gender = gender?? GenderType.male,
        _deviceToken = deviceToken,
        _mobile = mobile,
        _isNotificationEnabled = isNotificationEnabled,
        _mobileCountry = mobileCountry;



  Country get mobileCountry => _mobileCountry;

  bool get isNotificationEnabled => _isNotificationEnabled;


  String? get mobile => _mobile;

  String? get deviceToken => _deviceToken;


  GenderType get gender => _gender;

  set mobileCountry(Country value)  => _mobileCountry = value;

  set gender(GenderType value) => _gender = value;
  void setImage(String value) => _image = value;

  String? get email => _email;

  String? get name => _name;

  String? get dateOfBirth => _dateOfBirth;
  String? get image => _image;
}
