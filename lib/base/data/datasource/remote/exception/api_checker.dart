
import 'package:base_app/app.dart';
import 'package:base_app/base/data/model/base/base_model.dart';
import 'package:base_app/base/data/model/base/error_response.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/auth/domain/provider/local_auth_provider.dart';
import 'package:base_app/features/auth/route_generator.dart';

import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/utils/alerts.dart';
import 'package:base_app/core/utils/logger.dart';
import 'error_model.dart';

class ApiChecker {
  static const _tag = 'ApiChecker';
  static ErrorModel getAPIError({bool showError=true, dynamic error}){
    if(error ==null ) return ErrorModel(code: ErrorEnum.other, errorMessage: tr(LocaleKeys.error));

    if (error is BaseModel) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(error.response);
      if (errorResponse.message != null && errorResponse.message!.isNotEmpty) {
        log('ApiErrorHandler', 'default ${errorResponse.message}');
        return ErrorModel(code: ErrorEnum.other, errorMessage:tr(errorResponse.message??LocaleKeys.error));
      } else {
        return ErrorModel(code: ErrorEnum.other, errorMessage:tr(LocaleKeys.error));
      }
    }else if (error is String) {
      return ErrorModel(code: ErrorEnum.other, errorMessage:error);

    } else if (error is ErrorModel) {
      return error;
    }  else {
      return ErrorModel(code: ErrorEnum.other, errorMessage: tr(LocaleKeys.error));
    }
  }


  static ApiResult<T> checkApi<T>({bool showError=true, dynamic error /*String? message, ErrorModel? errorModel, BaseModel? baseModel*/}) {
    // log(_tag, 'checkApi  $message');

    ErrorModel apiError = ApiChecker.getAPIError(showError: showError, error: error);
    log(_tag, 'checkApi  ${apiError.errorMessage}');


    if (error.code == ErrorEnum.auth) {_onLogout();}else{_showAlert(apiError.errorMessage, showError);}
    return ApiResult<T>.failure( apiError);



  }

  static _showAlert(String? error,bool showError ) {
    log(_tag, '_showAlert == $error');

    if (error != null && showError) Alerts.showSnackBar(error);
  }
  static _onLogout() {
    if (appContext ==null) {return;}
    Provider.of<LocalAuthProvider>(appContext!, listen: false).deleteLocalData().then((isCleared) {
      NavigationService.goBack();
      NavigationService.pushNamedAndRemoveUntil(AuthRoutes.loginScreen);
    });
  }
}


// import 'package:base_app/app.dart';
// import 'package:base_app/base/data/model/base/response_model.dart';
// import 'package:base_app/core/routing/navigation_services.dart';
// import 'package:base_app/features/auth/domain/provider/local_auth_provider.dart';
// import 'package:base_app/features/auth/route_generator.dart';
//
// import 'package:base_app/generated/locale_keys.g.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../../../core/utils/alerts.dart';
// import 'package:base_app/core/utils/logger.dart';
// import 'error_widget.dart';
//
// class ApiChecker {
//   static const _tag = 'ApiChecker';
//   static ResponseModel<T> checkApi<T>({bool showError=true, String? message, ErrorModel? errorModel}) {
//     // log(_tag, 'checkApi  $message');
//     if (message != null) {
//       _showAlert(message, showError);
//       return ResponseModel<T>(false, tr(LocaleKeys.error));
//     } else if (errorModel != null) {
//       // log(_tag, 'checkApi errorModel $errorModel');
//       if (errorModel.code == ErrorEnum.auth) {_onLogout();}else{_showAlert(errorModel.errorMessage, showError);}
//       return ResponseModel<T>(false, tr(LocaleKeys.error));
//     }  else {
//       _showAlert(tr(LocaleKeys.error), showError);
//       return ResponseModel<T>(false, tr(LocaleKeys.error));
//     }
//   }
//
//   static _showAlert(String? error,bool showError ) {
//     log(_tag, '_showAlert == $error');
//
//     if (error != null && showError) Alerts.showSnackBar(error);
//   }
//   static _onLogout() {
//     if (appContext ==null) {return;}
//     Provider.of<LocalAuthProvider>(appContext!, listen: false).deleteLocalData().then((isCleared) {
//       NavigationService.goBack();
//       NavigationService.pushNamedAndRemoveUntil(AuthRoutes.loginScreen);
//     });
//   }
// }
