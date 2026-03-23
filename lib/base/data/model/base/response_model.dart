import '../../datasource/remote/exception/error_model.dart';

class ResponseModel<T> {
  final num? _code;
  final bool _isSuccess;
  final String? _message;
  final ErrorModel? _error;
  T? data;

  ResponseModel(
    this._isSuccess,
    this._message, {
    this.data,
    num? code,
    ErrorModel? error,
  })  : _error = error,
        _code = code;

  num? get code => _code;

  String? get message => _message;

  ErrorModel? get error => _error;

  bool get isSuccess => _isSuccess;
// dynamic get data => data;
}
