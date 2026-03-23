import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/base/data/model/base/error_response.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:base_app/core/utils/logger.dart';

class ApiErrorHandlerNew {
  static ErrorModel getMessage(error) {
    if (error is Exception) {

      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return  ErrorModel(code: ErrorEnum.cancel,errorMessage: tr(LocaleKeys.noConnection));
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.connectionError:
            case DioExceptionType.badCertificate:
              return   ErrorModel(code: ErrorEnum.connectTimeout,errorMessage: tr(LocaleKeys.noConnection));
            case DioExceptionType.receiveTimeout:
              return  ErrorModel(code: ErrorEnum.receiveTimeout,errorMessage: tr(LocaleKeys.noConnection));
            case DioExceptionType.sendTimeout:
              return  ErrorModel(code: ErrorEnum.sendTimeout,errorMessage: tr(LocaleKeys.noConnection));
            case DioExceptionType.unknown:
              return  ErrorModel(code: ErrorEnum.other,errorMessage: tr(LocaleKeys.noConnection),);
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 503:return ErrorModel(code: ErrorEnum.server,errorMessage:  error.response?.statusMessage??'server');

                case 401:return const ErrorModel(code: ErrorEnum.auth,errorMessage:  'Unauthorized');
                case 404:
                case 500:
                default:
                  ErrorResponse errorResponse = ErrorResponse.fromJson(error.response!.data);
                  if (errorResponse.message != null && errorResponse.message!.isNotEmpty) {
                    log('ApiErrorHandlerNew', 'default ${errorResponse.message}');
                    return ErrorModel(code: ErrorEnum.otherError,errorMessage:  errorResponse.message??'Error');
                  } else {
                    return  ErrorModel(code: ErrorEnum.otherError,errorMessage: "Failed to load data - status code: ${error.response!.statusCode}");
                  }
              }
              break;

          }
        } else {
          return   const ErrorModel(code: ErrorEnum.otherError,errorMessage: "Unexpected error occured");
        }
      } on FormatException catch (e) {
        return  ErrorModel(code: ErrorEnum.otherError,errorMessage:  e.toString());
      }catch (e){
        return  ErrorModel(code: ErrorEnum.otherError,errorMessage:  e.toString());
      }
    } else {
      return  const ErrorModel(code: ErrorEnum.otherError,errorMessage:  "is not a subtype of exception");
    }
  }
}
