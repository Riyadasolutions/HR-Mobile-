
import 'package:base_app/base/data/model/base/response_model.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/features/auth/domain/usecase/local/currency/get_currency_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/currency/save_currency_usecase.dart';


import 'package:flutter/material.dart';

import 'package:base_app/core/utils/logger.dart';



class CurrencyPickerViewModel with ChangeNotifier {
  final tag = 'CurrencyPickerViewModel';

  final SaveUserCurrencyUseCase _saveUserCurrencyUseCase;
  final GetUserCurrencyUseCase _getUserCurrencyUseCase;

  CurrencyPickerViewModel({
    required SaveUserCurrencyUseCase saveUserCurrencyUseCase,
    required GetUserCurrencyUseCase getUserCurrencyUseCase,
  })
      : _saveUserCurrencyUseCase = saveUserCurrencyUseCase,
        _getUserCurrencyUseCase = getUserCurrencyUseCase;

  ///variables
  List<String>?_currencies;
  String? _selected;

  ///getters
  List<String>? get currencies => _currencies;
  String? get selected => _selected;

  ///On update/change
  init( ) {
    getList(reload:false);
    _selected = kUserCurrency;
  }

  //on select item with Radio
  void onSelected(String value) {
    log(tag, 'onSelected: $value');

    _selected = value;
    notifyListeners();
  }

  

  ///Call APIs
  //get Assigned shops
  Future<void> getList({required bool reload}) async {
    // if(_currencies != null && !reload) {log(tag, 'getList: already loaded');return;}

    // if (reload) {notifyListeners();}
    _currencies = Constants.kSupportedCurrencies;

    // notifyListeners();
  }


  Future<bool> saveCurrency(String symbol) async {
    ResponseModel currencies =await  _saveUserCurrencyUseCase.call(symbol: symbol);
    if (currencies.isSuccess) {kUserCurrency = symbol;}
    notifyListeners();
    return currencies.isSuccess;
  }



}
