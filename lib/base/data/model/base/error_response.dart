

import 'package:base_app/core/utils/logger.dart';

class ErrorResponse {
  List<Errors>? _errors;
  List<Errors>? get errors => _errors;

  String? _message;
  String? get message => _message;

  ErrorResponse({List<Errors>? errors}) {
    _errors = errors;
  }

  ErrorResponse.fromJson(dynamic json) {
    _errors = [];
    log('ErrorResponse', 'Error ${json["message"].toString()}');
    if (((json["message"]??'').toString()).isNotEmpty) {
      _errors!.add(Errors('error', json["message"]));
      _message =  json["message"];
      log('ErrorResponse Errors', _message??'');
    }else if (json["data"] != null) {
      if (json["data"] is String) {
        _message = json["data"];
      } else {
        try{
          Map<String, dynamic> error = json["data"];
          for (String key in error.keys) {
            String errorString = error[key][0];

            if (_message == null) {
              _message = errorString;
            } else if(errorString.isNotEmpty){
              _message = '$_message \n $errorString';
            }

            _errors!.add(Errors(key, errorString));
            // log('Errors', 'Error ${_errors.toString()}');
          }
        }catch(e){
          // log('Errors', 'Error is List');

          for (String errorString in (json["data"] ?? [])) {
            // log('Errors', 'Error is List $errorString');

            if (_message == null) {
              _message = errorString;
            } else if(errorString.isNotEmpty){
              _message = '$_message \n $errorString';
            }
          }
          log('Errors', 'Error $_message');

        }

      }
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_errors != null) {
      map["errors"] = _errors!.map((v) => v).toList();
    }
    return map;
  }
}

/// code : "l_name"
/// message : "The last name field is required."

class Errors {
  final String? _key;
  final String? _value;

  String? get key => _key;

  String? get value => _value;

  Errors(this._key, this._value);

  @override
  String toString() {
    return 'Errors{_key: $_key, _value: $_value}';
  }
}

