import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/entity/privacy_entity.dart';
import 'package:base_app/features/common/domain/usecase/common/get_privacy_usecase.dart';
import 'package:flutter/material.dart';

class PrivacyViewModel extends ChangeNotifier {
  final GetPrivacyUseCase _getPrivacyUseCase;

  PrivacyViewModel({
    required GetPrivacyUseCase getPrivacyUseCase,
  }) : _getPrivacyUseCase = getPrivacyUseCase;

  ///variables
  ApiResult<PrivacyEntity>? _responseModel;

  ///getters
  ApiResult<PrivacyEntity>? get responseModel => _responseModel;

  Future<void> getPrivacy({bool reload = false}) async {
    _responseModel = null;
    if (reload) {
      notifyListeners();
    }
    _responseModel = await _getPrivacyUseCase.call();
    notifyListeners();
  }
}
