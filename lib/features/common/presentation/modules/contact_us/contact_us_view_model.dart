import 'package:base_app/base/presentation/component/inputs/country/countries.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/parameters/contact_us_parameters.dart';
import 'package:base_app/features/common/domain/usecase/common/contact_us_usecase.dart';
import 'package:flutter/material.dart';

class ContactUsViewModel extends ChangeNotifier {
  final ContactUsUseCase _contactUsUseCase;

  ContactUsViewModel({
    required ContactUsUseCase contactUsUseCase,
  }) : _contactUsUseCase = contactUsUseCase;

  bool _isLoading = false;
  ApiResult? _responseModel;

  bool get isLoading => _isLoading;
  ApiResult? get responseModel => _responseModel;
  ContactUsParameters _parameters = ContactUsParameters();
  init(){
    _parameters = ContactUsParameters();
  }
  ///On update/change
  onUpdateMobileCountryCode(Country value){_parameters.mobileCountry=value ; notifyListeners();}



  Future<void> contactUsRequest({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) async {
    _isLoading = true;
    notifyListeners();
    _parameters.setData(name: name, email: email, phone: phone, subject: subject, message: message);
    _responseModel = await _contactUsUseCase.call(
      parameters:_parameters,
    );
    _isLoading = false;
    notifyListeners();
  }
}
