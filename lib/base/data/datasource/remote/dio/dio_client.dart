import 'dart:convert';
import 'dart:io';

import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/utils/validators.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../app.dart';
import 'package:base_app/core/utils/logger.dart';
import '../../local/cache_consumer.dart';
import '../../local/storage_keys.dart';
import 'logging_interceptor.dart';
String kDeviceType = Platform.isIOS?'ios':'android';
class DioClient {
  final String baseUrl;
  final LoggingInterceptor loggingInterceptor;
  final CacheConsumer cacheConsumer;

  Dio? dio;
  String? _token;
  String? _currency;

  set currency(String value) =>_currency = value;
  set token(String? value) =>_token = value;



  _getLocaleData()async {

    ///get the token from cache if not set
    try{
      _currency =_currency?? cacheConsumer.get(StorageKeys.kCurrency)?? Constants.kDefaultCurrencySymbol;
      _token = _token??await cacheConsumer.getSecuredData(StorageKeys.kToken);
    }catch(e){
      log('_setHeaders', e.toString());
    }

  }


  // _getToken() async{
  //   // if (token == null || subDomain ==null) {
  //   token = await cacheConsumer.getSecuredData(StorageKeys.kToken);
  //   if(null !=_token  ) {
  //     log('_getToken', _token.toString());
  //     dio?.options.headers.addAll({'Authorization': 'Bearer $_token','device_type':kDeviceType});
  //   }
  // }
  DioClient(
      this.baseUrl,
      Dio? dioC, {
        required this.loggingInterceptor,
        required this.cacheConsumer,
      }) {

    dio = dioC ?? Dio();

    dio!
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = Duration(seconds: 60)
      ..options.receiveTimeout = Duration(seconds: 60)
      ..httpClientAdapter
      ..options.headers = {
        'Accept': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json; charset=UTF-8',

        'language':   (appContext?.locale.languageCode ??Constants.kSupportedLocales[0]),
        'Accept-Language':   (appContext?.locale.languageCode ??Constants.kSupportedLocales[0]),
        'Content-Language':   (appContext?.locale.languageCode ??Constants.kSupportedLocales[0]),
        if(_token!=null)'Authorization': 'Bearer $_token',
        'device_type':kDeviceType
      };

    _getLocaleData();
    dio!.interceptors.add(loggingInterceptor);
  }

  _updateHeaders(){
    _getLocaleData();
    dio!.options.headers.addAll({
      'Accept-Currency': _currency,
      'language':   (appContext?.locale.languageCode ??Constants.kSupportedLocales[0]),
      'Accept-Language':   (appContext?.locale.languageCode ??Constants.kSupportedLocales[0]),
      'Content-Language':   (appContext?.locale.languageCode ??Constants.kSupportedLocales[0]),
      if(_token!=null)'Authorization': 'Bearer $_token',
    });
  }
  Future<Response> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        bool? isRow ,

      }) async {
    log('getgetget', _token.toString());
    _updateHeaders();

    try {
      var response = await dio!.get(
        uri,
        data: (isRow??false)?jsonEncode(queryParameters):null,

        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
      String uri, {

        // FormData? data,
        Map<String, dynamic>? dataParameters,
        Map<String, dynamic>? queryParameters,
        Options? options,
        String? filePath,

        List<String>? filePathList,
        String? filePathListName,

        List<FileModel>? filePathNamedList,
        String? fileName,
        List<FileModel>? filesPath,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? isRow ,
      }) async {
    _updateHeaders();
    try {
      Map<String, dynamic> body = queryParameters ?? dataParameters??{};

      Map<String, dynamic>?  files = await _buildFileData(filePath: filePath, filesPath: filesPath, filePathList: filePathList, filePathListName: filePathListName, fileName: fileName);
      //files
      // log('Dio', 'Data $data');
      // log('Dio', 'post headers ${uri}${dio?.options.headers}');
      if(files.isNotEmpty){
        body.addAll(files);
      }


      log('Dio', 'Body $body');
      FormData data = FormData.fromMap(body);


      var response = await dio!.post(
        uri,
        data: (isRow??false)?jsonEncode(queryParameters):data,

        // queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      log('post', 'Unable to process the data');
      throw const FormatException("Unable to process the data");
    } catch (e) {
      // log('post::', e.toString());

      rethrow;
    }
  }


  Future<Response> put(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    _updateHeaders();
    try {
      var response = await dio!.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> update(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    _updateHeaders();
    try {
      var response = await dio!.post(
        '$uri?_method=put',
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    _updateHeaders();
    try {
      var response = await dio!.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}


Future< Map<String, dynamic>> _buildFileData({
  required String? filePath,
  required List<FileModel>? filesPath,
  required List<String>? filePathList,
  required String? filePathListName,
  required String? fileName,
}) async {

  Map<String, dynamic> body = {} ;
  if ((filePath??'').isNotEmpty) {
    if(!Validators.isURL(filePath)){
      String fName = filePath!.split('/').last;
      body.addAll({fileName??"file": await MultipartFile.fromFile(filePath, filename: fName),});
      // data = FormData.fromMap(body);
    }

    // String fName = filePath.split('/').last;
    // Map<String, dynamic> body ={fileName??"file": await MultipartFile.fromFile(filePath, filename: fName),};
    //
    // data = FormData.fromMap(body);

  }else if (filePathList != null) {
    for (var i = 0; i <= (filePathList.length)-1; i++) {
      String path = filePathList[i];

      if(!Validators.isURL(path)){


        // for(String path in file.paths??[]){
        log('dio', 'files name: ${filePathListName?? "images"}[$i] - path: $path  ');
        String fileName = path.split('/').last;
        body.addAll({'${filePathListName?? "images"}[$i]': await MultipartFile.fromFile(path, filename: fileName)});
      }
    }

    // List<MultipartFile> list = [];
    // for(String path in filePathList){
    //   if(!Validators.isURL(path)){
    //     String fileName = path.split('/').last;
    //     list.add(await MultipartFile.fromFile(path, filename: fileName) );
    //     // data = FormData.fromMap({filePathListName?? "images[]":});
    //     // data = FormData.fromMap({filePathListName?? "images[]": await MultipartFile.fromFile(path, filename: fileName)});
    //   }
    //   if(list.isNotEmpty)
    //   data = FormData.fromMap({filePathListName?? "images[]": list});
    // }
  }else if (filesPath != null) {
    // Map<String, dynamic> body = {} ;
    for(FileModel file in filesPath){

      if (file.path !=  null) {
        log('dio', 'file - name: ${file.name} - path: ${file.path}  ');
        String fileName = file.path!.split('/').last;
        if(!Validators.isURL(file.path!)){
          body.addAll({ file.name: await MultipartFile.fromFile(file.path!, filename: fileName)});
        }else{
          body.addAll({ file.name:file.path!});

        }
      } else{
        for (var i = 0; i <= (file.paths?.length??0)-1; i++) {
          String path = file.paths![i];
          // for(String path in file.paths??[]){
          log('dio', 'files name: ${file.name}[$i] - path: $path  ');
          String fileName = path.split('/').last;
          body.addAll({'${file.name}[${i+1}]': await MultipartFile.fromFile(path, filename: fileName)});
        }
      }
    }
    // data = FormData.fromMap(body);
  }

  FormData? data = FormData.fromMap(body);
  // log('dio', 'files123123 ${data.fields.length}');
  // log('dio', 'files123123 ${data.files.length}');
  // log('dio', 'files123123 ${body}');

  return body;
}


class FileModel{
  final String name;
  final String? path;
  final List<String>? paths;

  const FileModel({
    required this.name,
    this.path,
    this.paths,
  });
}
