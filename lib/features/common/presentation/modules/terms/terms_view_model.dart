import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/entity/terms_entity.dart';
import 'package:base_app/features/common/domain/usecase/common/get_terms_usecase.dart';
import 'package:flutter/material.dart';

class TermsViewModel extends ChangeNotifier {
  final GetTermsUseCase _getTermsUseCase;

  TermsViewModel({
    required GetTermsUseCase getTermsUseCase,
  }) : _getTermsUseCase = getTermsUseCase;

  ///variables
  ApiResult<TermsEntity>? _responseModel;

  ///getters
  ApiResult<TermsEntity>? get responseModel => _responseModel;

  Future<void> getTerms({bool reload = false}) async {
    _responseModel = null;
    if (reload) {
      notifyListeners();
    }
    _responseModel = await _getTermsUseCase.call();
    notifyListeners();
  }
}
