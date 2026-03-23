import 'dart:async';

import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/usecase/common/get_cities_usecase.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/logger.dart';



class CityPickerViewModel with ChangeNotifier {
  final tag = 'CityPickerViewModel';
  final GetCitiesUseCase _getCitiesUseCase ;

  CityPickerViewModel({
    required GetCitiesUseCase getCitiesUseCase,
  }) : _getCitiesUseCase = getCitiesUseCase;

  ///variables
  ApiResult<List<DropDownEntity>>? _responseModel;
  List<DropDownEntity> _viewList = [];
  DropDownEntity? _selected;
  List<DropDownEntity>? _selectedList = [];
  bool _isSelectAllEnable = false;

  ///getters
  ApiResult<List<DropDownEntity>>? get responseModel => _responseModel;
  DropDownEntity? get selected => _selected;
  List<DropDownEntity>? get selectedList => _selectedList;
  List<DropDownEntity> get viewList => _viewList;
  bool get isSelectAllEnable => _isSelectAllEnable;

  setAddAll(bool isSelectAllEnable) {
    _isSelectAllEnable = isSelectAllEnable;
    if (isSelectAllEnable) {
      _selectedList = _responseModel?.data ?? [];
    } else {
      _selectedList = [];
    }

    notifyListeners();
  }

  init(BuildContext context,{DropDownEntity? defaultValue,required List<DropDownEntity> defaultList,required int countryId,required bool isSelectAllEnable }) {
    _viewList = [];
    _selectedList = defaultList;
    _selected = defaultValue;
    _isSelectAllEnable = isSelectAllEnable;
    getList(reload:false,countryId: countryId);
  }

  Future<void> getList({required int countryId,required bool reload}) async {
    _responseModel = null;
    if (reload) {notifyListeners();}
    _responseModel = await _getCitiesUseCase.call(countryId: countryId);
    if((_responseModel?.isSuccess??false)){
    //   if(_isSelectAllEnable){
    //     // _responseModel!.data = [DropDownEntity(id: 0, title: tr(LocaleKeys.all), key: 'selectAll'),..._responseModel!.data!] ;
    //     _selected = _selected?? _responseModel!.data![0];
    // }
    _viewList =  _responseModel!.data??[];

  }

    notifyListeners();
  }


  onSearch(String key){
    if(key.isEmpty){
      _viewList = _isSelectAllEnable?_responseModel!.data!:_responseModel!.data??[];
    }else{
      _viewList = _isSelectAllEnable?[DropDownEntity(id: 0, title: tr(LocaleKeys.all), key: 'selectAll')]:[];
      final searchKey = key.toLowerCase();
      for(DropDownEntity entity in _responseModel!.data??[]){
        if(entity.title.toLowerCase().contains(searchKey)){
          _viewList.add(entity);
        }
      }
    }
    if(_viewList.length==1)_viewList=[];


    notifyListeners();
  }


  void onItemChecked({required bool isChecked, required DropDownEntity selectedItem}) {
    if(selectedItem.key =='selectAll'){
      if(isChecked){
        _selectedList = _viewList;
      }else{
        _selectedList=[];
      }
      notifyListeners();
      return;
    }
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
