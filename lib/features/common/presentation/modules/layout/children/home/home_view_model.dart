import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/common/domain/entity/home_data_entity.dart';
import 'package:base_app/features/common/domain/entity/home_entity.dart';
import 'package:base_app/features/common/domain/usecase/common/home_usecase.dart';
import 'package:base_app/features/common/domain/usecase/notification/get_notification_count_usecase.dart';
import 'package:flutter/material.dart';


class HomeViewModel extends ChangeNotifier {
  final _tag = 'HomeViewModel';

  final GetHomeUseCase _getHomeUseCase;
  final GetNotificationCountUseCase _getNotificationCountUseCase;

  HomeViewModel({
    required GetHomeUseCase getHomeUseCase,
    required GetNotificationCountUseCase getNotificationCountUseCase,
  })  : _getHomeUseCase = getHomeUseCase,
        _getNotificationCountUseCase = getNotificationCountUseCase;

  ///Variables
  ApiResult<List<HomeEntity>>? _responseModel;


  ///Getters
  ApiResult<List<HomeEntity>>? get responseModel => _responseModel;

  ///colling api functions

  init({bool reload = false}) {
    getHome(reload: reload);
  }

  //get home
  getHome({bool reload = false}) async {
    _responseModel = null;
    if (reload) {
      notifyListeners();
    }
    _responseModel = await _getHomeUseCase.call();
    notifyListeners();
  }



}
