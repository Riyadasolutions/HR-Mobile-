import 'dart:async';

import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/usecase/common/get_countries_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_nationalities_usecase.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/logger.dart';




class NationalityPickerViewModel with ChangeNotifier {
  final tag = 'NationalityPickerViewModel';

  final GetNationalitiesUseCase _getNationalitiesUseCase;
  NationalityPickerViewModel({
    required GetNationalitiesUseCase getNationalitiesUseCase,
  }) : _getNationalitiesUseCase = getNationalitiesUseCase;




  ///variables
  ApiResult<List<DropDownEntity>>? _responseModel;
  DropDownEntity? _selected;
  List<DropDownEntity>? _selectedList = [];
  bool? _addAll;

  ///getters
  ApiResult<List<DropDownEntity>>? get responseModel => _responseModel;
  DropDownEntity? get selected => _selected;
  List<DropDownEntity>? get selectedList => _selectedList;


  init({DropDownEntity? defaultValue,List<DropDownEntity>? defaultList,required bool addAll }) {

    getList(reload:false);
    _selected = defaultValue;
    _selectedList = defaultList;
    _addAll = addAll;
  }

  Future<void> getList({required bool reload}) async {

    if (reload) {notifyListeners();}
    _responseModel = await _getNationalitiesUseCase.call();
    if((_responseModel?.isSuccess??false) &&(_addAll??false)){
      // _responseModel!.data = [DropDownEntity(id: 0, title: tr(LocaleKeys.all), key: 'all'),..._responseModel!.data!] ;
      // _selected = _selected?? _responseModel!.data![0];
    }

    notifyListeners();
  }

  void onItemChecked({required bool isChecked, required DropDownEntity selectedItem}) {
    log(tag, 'onItemChecked: isChecked= $isChecked id= $selectedItem');
    if (isChecked) {
      log(tag, 'onItemChecked: add');_selectedList!.add(selectedItem);
    } else {
      log(tag, 'onItemChecked: remove');_selectedList!.removeWhere((item) => item.id == selectedItem.id);
    }
    _selectedList = [..._selectedList!];
    notifyListeners();
  }

  void onSelected(DropDownEntity value) {
    log(tag, 'onSelected: $value');

    _selected = value;
    notifyListeners();
  }
}
