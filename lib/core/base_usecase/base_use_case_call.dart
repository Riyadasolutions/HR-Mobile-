//
//
// import 'package:base_app/core/utils/alerts.dart';
// import 'package:base_app/generated/locale_keys.g.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
//
// import '../utils/logger.dart';
// import 'package:base_app/base/data/datasource/remote/exception/api_checker.dart';
// import 'package:base_app/base/data/model/base/api_response.dart';
// import 'package:base_app/base/data/model/base/base_model.dart';
// import 'package:base_app/base/data/model/base/response_model.dart';
// class BaseUseCaseCall<R>{
//   static ResponseModel<R> onGetData<R>(ApiResponse apiResponse, ResponseModel<R> Function(BaseModel baseModel) onConvert,{bool showError = true,String? successMessage,bool showSuccess = false,String? tag}){
//     ResponseModel<R> responseModel;
//
//     _log(tag,apiResponse.response );
//     if (apiResponse.response != null &&( apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201) ) {
//       BaseModel baseModel = BaseModel.fromJson(apiResponse.response!.data);
//       if (baseModel.status) {
//         // _log(tag,'getData successfully');
//         if (kDebugMode) {
//           // _log(tag,'getData kDebugMode');
//           try{
//             if(showSuccess) Alerts.showSnackBar(successMessage??(baseModel.message.isEmpty?tr(LocaleKeys.savedSuccessfully):baseModel.message),alertsType: AlertsType.success);
//           }catch(e){
//             if(showSuccess) Alerts.showSnackBar(successMessage??tr(LocaleKeys.savedSuccessfully),alertsType: AlertsType.success);
//           }
//           responseModel = onConvert(baseModel);
//         } else{
//           try {
//             responseModel = onConvert(baseModel);
//             try{
//               if(showSuccess) Alerts.showSnackBar(baseModel.message,alertsType: AlertsType.success);
//             }catch(e){}
//           } catch (e) {
//             _log(tag,'getData onConvert Error');
//             responseModel = ApiChecker.checkApi<R>( message: baseModel.message,showError: showError);
//           }
//         }
//       } else {
//         _log(tag,'getData onConvert Error ${ baseModel.responseData[0]}');
//         responseModel = ApiChecker.checkApi<R>(showError: showError, message: baseModel.responseData[0]);
//         // _log(tag,'getData onConvert Error ${ baseModel.message}');
//         // if(baseModel.responseData is List){
//         //   String error = (baseModel.responseData as List).join('\n');
//         //   responseModel = ApiChecker.checkApi<R>(showError: showError, message: error);
//         //
//         // }else if(baseModel.code=='301'){
//         //   responseModel = ResponseModel(false, baseModel.message,error: ErrorModel(code: ErrorEnum.verify, errorMessage: baseModel.message));
//         // }else{
//         //   _log(tag,'getData onConvert Error ${ baseModel.responseData[0]}');
//         //
//         //   responseModel = ApiChecker.checkApi<R>(showError: showError, message: baseModel.responseData[0]);
//         //   // responseModel = ApiChecker.checkApi<R>(showError: showError, message: baseModel.message);
//         // }
//
//         // responseModel = ApiChecker.checkApi<R>(showError: showError, message: apiResponse.response?.data);
//       }
//     } else {
//       // _log(tag,'getData onConvert API Error11 - ${apiResponse.error}');
//       responseModel =ApiChecker.checkApi<R>(showError: showError, errorModel: apiResponse.error,);
//
//       // _log(tag,'getData onConvert API Error - ${apiResponse.error??apiResponse.response?.data['message']}');
//       //
//       // responseModel = ApiChecker.checkApi<R>(showError: showError, errorModel: apiResponse.error??apiResponse.response?.data['message']);
//
//     }
//     return responseModel;
//   }
//
//
// }
// _log(String? tag,var massage){
//   if (tag!=null) {
//     log(tag, 'response :$massage ');
//   }
// }