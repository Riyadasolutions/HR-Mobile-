
import 'package:base_app/base/data/datasource/remote/exception/api_checker.dart';
import 'package:base_app/base/data/model/base/base_model.dart';
import 'package:base_app/base/data/model/base/response_model.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

import '../../../../../../../core/utils/alerts.dart';


class ApiHelper<R>{
  static ApiResult<R> check<R>(Response? apiResponse, ApiResult<R>  Function(BaseModel baseModel) onConvert,{bool showError = true,String? successMessage,bool showSuccess = false,String? tag}){
    ApiResult<R> responseModel;

    _log(tag,apiResponse );
    if (apiResponse != null &&( apiResponse.statusCode == 200 || apiResponse.statusCode == 201) ) {
      BaseModel baseModel = BaseModel.fromJson(apiResponse.data);
      if (baseModel.status) {
        if (kDebugMode) {
          try{
            if(showSuccess) Alerts.showSnackBar(successMessage??(baseModel.message.isEmpty?tr(LocaleKeys.savedSuccessfully):baseModel.message),alertsType: AlertsType.success);
          }catch(e){
            if(showSuccess) Alerts.showSnackBar(successMessage??tr(LocaleKeys.savedSuccessfully),alertsType: AlertsType.success);
          }
          responseModel = onConvert(baseModel);
        } else{
          try {
            responseModel = onConvert(baseModel);
            try{
              if(showSuccess) Alerts.showSnackBar(baseModel.message,alertsType: AlertsType.success);
            }catch(e){}
          } catch (e) {
            _log(tag,'getData onConvert Error');
            responseModel = ApiChecker.checkApi<R>( error: baseModel.message,showError: showError);
          }
        }
      } else {
        _log(tag,'getData onConvert Error ${ baseModel.message}');
        // _log(tag,'getData onConvert ErrorresponseModel ${ baseModel.error}');

        responseModel = ApiChecker.checkApi<R>(showError: showError, error: baseModel.message);

        // try{
       //   responseModel = ApiChecker.checkApi<R>(showError: showError, error: baseModel);
       // }catch(e){
       //   _log(tag,'getData onConvert ErrorresponseModel ${ e.toString()}');
       //
       //   responseModel = ApiChecker.checkApi<R>(showError: showError, error: tr(LocaleKeys.error) );
       // }

      }
    } else {
      _log(tag,'getData onConvert Error ${ apiResponse?.data['message']}');
      responseModel =ApiChecker.checkApi<R>(showError: showError, error:apiResponse?.data['message']?? tr(LocaleKeys.error) );
    }
    return responseModel;
  }


}
_log(String? tag,var massage){
  if (tag!=null) {
    log(tag, 'response :$massage ');
  }
}
