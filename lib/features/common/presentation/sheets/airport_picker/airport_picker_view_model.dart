import 'dart:async';

import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/usecase/common/get_airport_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_countries_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_nationalities_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_visa_types_usecase.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/logger.dart';




class AirportPickerViewModel with ChangeNotifier {
  final tag = 'AirportPickerViewModel';

  final GetAirportsUseCase _getAirportsUseCase;
  AirportPickerViewModel({
    required GetAirportsUseCase getAirportsUseCase,
  }) : _getAirportsUseCase = getAirportsUseCase;




  ///variables
  ApiResult<List<DropDownEntity>>? _responseModel;
  List<DropDownEntity> _viewList = [];
  DropDownEntity? _selected;
  List<DropDownEntity>? _selectedList = [];
  bool? _addAll;

  ///getters
  ApiResult<List<DropDownEntity>>? get responseModel => _responseModel;
  List<DropDownEntity> get viewList => _viewList;
  DropDownEntity? get selected => _selected;
  List<DropDownEntity>? get selectedList => _selectedList;


  init({DropDownEntity? defaultValue,List<DropDownEntity>? defaultList,required bool addAll, required int countryId }) {
    _viewList = [];
    _selected = defaultValue;
    _selectedList = defaultList;
    _addAll = addAll;
    getList(reload:false, countryId: countryId);
  }

  Future<void> getList({required bool reload, required int countryId}) async {
    _responseModel = null;
    if (reload) {notifyListeners();}
    _responseModel = await _getAirportsUseCase.call(countryId: countryId);
    if((_responseModel?.isSuccess??false)){
      _viewList = _responseModel!.data??[];
    }

    notifyListeners();
  }

  onSearch(String key){
    if(key.isEmpty){
      _viewList = _responseModel?.data??[];
    }else{
      _viewList = [];
      final searchKey = key.toLowerCase();
      for(DropDownEntity entity in _responseModel?.data??[]){
        if(entity.title.toLowerCase().contains(searchKey)){
          _viewList.add(entity);
        }
      }
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
