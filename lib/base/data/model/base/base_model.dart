class BaseModel<E> {
  final bool _status;
  final String _code;
  final dynamic _message;
  final E? _responseData;
  final dynamic _response;

  factory BaseModel.fromJson(dynamic json) {
    if(json is Map<String, dynamic> ){
      return  BaseModel(
          status: (json['success']==true)||(json['status']=='success'|| json['status']==null ),
          code: (json['status']??'success').toString(),
          message: json['message']??"Error",
          responseData: json['data'], response: json
      );
    }else{
      return BaseModel(status: true, code: '', message: "", responseData: json,  response: json);
    }

  }



  const BaseModel({
    required bool status,
    required String code,
    required dynamic message,
    required E? responseData,
    required dynamic response,
  })  : _status = status,
        _code = code,
        _message = message,
        _responseData = responseData,
        _response = response;

  dynamic get response => _response;

  E? get responseData => _responseData;

  dynamic get message => _message;

  String get code => _code;

  bool get status => _status;
}
