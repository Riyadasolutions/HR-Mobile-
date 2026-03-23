import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:dio/dio.dart';


class ApiResponse<T> {

  final Response<T>? response;
  final ErrorModel? error;

  ApiResponse(this.response, this.error);

  ApiResponse.withError(dynamic errorValue)
      : response = null,
        error = errorValue;

  ApiResponse.withSuccess(Response<T> responseValue)
      : response = responseValue,
        error = null;

}

