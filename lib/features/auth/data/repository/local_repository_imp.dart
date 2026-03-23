
import 'package:base_app/base/data/datasource/local/storage_keys.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../app.dart';
import '../../../../base/data/datasource/local/cache_consumer.dart';
import '../../../../base/data/datasource/remote/dio/dio_client.dart';
import '../../domain/repository/local_repo.dart';


class LocalRepositoryImp implements LocalRepository {
  final DioClient _dioClient;
  final CacheConsumer _cacheConsumer;

  LocalRepositoryImp({
    required DioClient dioClient,
    required CacheConsumer cacheConsumer,
  })  : _dioClient = dioClient,
        _cacheConsumer = cacheConsumer;


  // for  user token
  @override
  Future<bool> saveSecuredData(String token) async {
    await _cacheConsumer.saveSecuredData(StorageKeys.kToken, token);
    log('saveSecuredData', 'token :$token');
    _dioClient.token = token;
    _dioClient.dio!.options.headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Content-Language': (appContext?.locale.languageCode ??'ar'),
      'Authorization': 'Bearer $token',
    };
    return await _cacheConsumer.save(StorageKeys.kIsAuthed, true) ;
  }

  @override
  Future<String> getUserToken() async {

    return await _cacheConsumer.getSecuredData(StorageKeys.kToken)??'';
  }

  @override
  bool getIsLoggedIn() {
    return _cacheConsumer.get(StorageKeys.kIsAuthed) ?? false;
  }

  @override
  Future<bool> clearSharedData() async {
    _cacheConsumer.deleteSecuredData();
    _cacheConsumer.delete(StorageKeys.kIsAuthed);
    await _cacheConsumer.delete(StorageKeys.kToken);
    kClearGlobalData();
    // _dioClient.t
    _dioClient.dio!.options.headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Content-Language':(appContext?.locale.languageCode ??'ar'),
      'Authorization': null,
    };
    return _cacheConsumer.delete(StorageKeys.kToken);
  }





  @override
  bool getIsFirstTime() {
   bool isFirstTime =  _cacheConsumer.get(StorageKeys.kIsFirstTime) ?? true;
   _cacheConsumer.save(StorageKeys.kIsFirstTime, false);
    return isFirstTime;
  }


  @override
  String getCurrency() {
    final symbol = _cacheConsumer.get(StorageKeys.kCurrency)?? Constants.kDefaultCurrencySymbol;
    _dioClient.currency = symbol;

    return symbol;
  }


  @override
  Future<bool> saveCurrency(String symbol) async {
    _dioClient.currency = symbol;
    return await  _cacheConsumer.save(StorageKeys.kCurrency,symbol) ;
  }

}
