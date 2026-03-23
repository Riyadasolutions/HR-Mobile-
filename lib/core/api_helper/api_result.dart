import 'package:base_app/base/data/datasource/remote/exception/api_checker.dart';
import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/base/data/datasource/remote/exception/error_model.dart';
import 'package:base_app/core/utils/alerts.dart';
import 'package:base_app/core/utils/logger.dart';

abstract class ApiResult<T> {
  const ApiResult();

  factory ApiResult.success(T response) = Success<T>;

  // factory ApiResult.failure(ErrorModel error, { bool showAlert = false}) = Failure<T>;

  factory ApiResult.failure(dynamic apiError, {bool showAlert = false}) => Failure<T>( apiError, showAlert: showAlert);

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  // T? get response => (this is Success<T>)?(this as Success<T>).response:null;
  T? get data => (this is Success<T>)?(this as Success<T>).response:null;




  ErrorModel? get error => isFailure ? this.error : null;
// ErrorModel? get error => (this is Failure<T>)?(this as Failure<T>).error:null;

  showAlert(){
    log('ssssssss', 'message');
    if((error?.errorMessage??'').isNotEmpty) Alerts.showSnackBar(error!.errorMessage);
  }
}

class Success<T> extends ApiResult<T> {
  final T _data;

  const Success(
      T data,
      ) : _data = data;

  T get response => _data;
}


class Failure<T> extends ApiResult<T> {
  final dynamic _apiError;
  final bool _showAlert;
  const Failure(dynamic apiError, {bool showAlert = false}): _apiError = apiError, _showAlert = showAlert;


  ErrorModel get error => ApiChecker.getAPIError(showError: _showAlert,error: _apiError);


  showAlert1(){
    Alerts.showSnackBar(error.errorMessage);
    if(_showAlert){
      // ApiChecker.checkApi(error.errorMessage);
      // Show alert logic can be implemented here
      Alerts.showSnackBar(error.errorMessage);
    }
  }

}


