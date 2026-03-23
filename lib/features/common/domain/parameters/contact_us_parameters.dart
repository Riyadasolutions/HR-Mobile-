import 'package:base_app/base/presentation/component/inputs/country/countries.dart';
import 'package:base_app/core/constants/constants.dart';

class ContactUsParameters {
  String? _name;
  String? _email;
  Country _mobileCountry;
  String? _phone;
  String? _subject;
  String? _message;

  ContactUsParameters({
    String? name,
    String? email,
    Country mobileCountry = Constants.initMobileCountry,
    String? phone,
    String? subject,
    String? message,
  }) : _name = name,
       _email = email,
       _mobileCountry = mobileCountry,
       _phone = phone,
       _subject = subject,
       _message = message;

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'email': _email,
      'phone_country_code': _mobileCountry,
      'phone': _phone,
      'subject': _subject,
      'message': _message,
    };
  }

  setData({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }){
    _name = name;
    _email = email;
    _phone = phone;
    _subject = subject;
    _message = message;

  }
  set mobileCountry(Country value) => _mobileCountry = value;
  Country get mobileCountry => _mobileCountry;
}
