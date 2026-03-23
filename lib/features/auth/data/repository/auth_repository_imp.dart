import 'dart:async';
import 'dart:io';

import 'package:base_app/base/data/datasource/remote/exception/api_helper.dart';
import 'package:base_app/core/api_helper/api_error_handler_new.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/auth/data/model/auth_model.dart';
import 'package:base_app/features/auth/data/urls.dart';
import 'package:base_app/features/auth/domain/entity/auth_entity.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';
import 'package:base_app/features/auth/domain/parameters/login_parameters.dart';
import 'package:base_app/features/auth/domain/parameters/register_parameters.dart';
import 'package:base_app/features/auth/domain/repository/auth_repo.dart';
import 'package:dio/dio.dart';

import '../../../../base/data/datasource/remote/dio/dio_client.dart';


class AuthRepositoryImp implements AuthRepository{
  final DioClient _dioClient;

  AuthRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;

  @override
  Future<ApiResult<AuthEntity>> login({required LoginParameters parameters}) async {
    try {
      Response response = await _dioClient.post(AuthURLs.kLoginURI, queryParameters: parameters.toJson());
      return  ApiHelper.check(response, (baseModel){
        AuthEntity? entity = AuthModel.fromJson(baseModel.response ).toEntity();
        return ApiResult<AuthEntity>.success(entity);
      },showError: true,tag:'login' );

    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }


  @override
  Future<ApiResult<AuthEntity>> verifyOtpCode({required ForgetPasswordParameters parameters})  async {

    try {
      Response response = await _dioClient.post( AuthURLs.kVerifyOtpCodeURI , queryParameters: parameters.toJson());
      return  ApiHelper.check(response, (baseModel){
        AuthEntity? entity = AuthModel.fromJson(baseModel.responseData ).toEntity();
        return ApiResult<AuthEntity>.success(entity);
      },showError: true);

    } catch (e) {
      log('verifyOtpCode', 'message');
     return  ApiResult.failure(ApiErrorHandlerNew.getMessage(e),showAlert: true)..showAlert();

    }
  }


  @override
  Future<ApiResult<AuthEntity>> register({required RegisterParameters parameters}) async {
    try {
      Response response = await _dioClient.post( AuthURLs.kRegisterURI , queryParameters: parameters.toJson());
      return  ApiHelper.check(response, (baseModel){
        AuthEntity? entity = AuthModel.fromJson(baseModel.responseData ).toEntity();
        return ApiResult<AuthEntity>.success(entity);
      },showError: true);

    } catch (e) {
      // ErrorModel error = ApiErrorHandlerNew.getMessage(e);
      // ApiChecker.checkApi( error: error.errorMessage,showError: true);
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e))..showAlert();
    }
  }


  Future<ApiResult> fcmTokenUpdate({ required String? fcmToken}) async {
    try {
      Response response = await _dioClient.post(AuthURLs.kFcmTokenUpdateURI, queryParameters: {"device_token": fcmToken, "device_type": Platform.isIOS ? 'ios' : 'android' });
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }


  @override
  Future<ApiResult> deleteAccount() async {
    try {
      Response response = await _dioClient.post(AuthURLs.kDeleteAccountURI);
      return  ApiHelper.check(tag: 'deleteAccount',response, (baseModel){
        return ApiResult.success(true);
      },showError: false);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }
  @override
  Future<ApiResult> logout() async {
    try {
      Response response = await _dioClient.post(AuthURLs.kLogoutURL);
      return  ApiHelper.check(tag: 'logout',response, (baseModel){
        return ApiResult.success(true);
      },showError: false);

    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }


  @override
  Future<ApiResult<AuthEntity>> checkOtpCode({required ForgetPasswordParameters parameters}) async {
    try {
      Response response = await _dioClient.post(AuthURLs.kVerifyOtpCodeURI, queryParameters: parameters.toJson());
      return  ApiHelper.check(tag: 'checkOtpCode',response, (baseModel){
        AuthEntity? entity = AuthModel.fromJson(baseModel.responseData ).toEntity();
        return ApiResult<AuthEntity>.success(entity);
      },showError: false);

    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }


  @override
  Future<ApiResult> forgetPassword({required ForgetPasswordParameters parameters}) async {
    try {
      Response response = await _dioClient.post(AuthURLs.kForgetPasswordURL, queryParameters: parameters.toJson());
      return  ApiHelper.check(tag: 'forgetPassword',response, (baseModel){
        return ApiResult.success(true);
      },showError: true);
    } catch (e) {
      log('verifyOtpCode', 'message');
      return  ApiResult.failure(ApiErrorHandlerNew.getMessage(e),showAlert: true)..showAlert();
      // return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

  @override
  Future<ApiResult<AuthEntity>> resetPassword({required ForgetPasswordParameters parameters})async {
    try {
      Response response = await _dioClient.post(AuthURLs.kResetPasswordURL, queryParameters: parameters.toJson());
      return  ApiHelper.check(tag: 'resetPassword',response, (baseModel){
        AuthEntity? entity = AuthModel.fromJson(baseModel.responseData ).toEntity();
        return ApiResult<AuthEntity>.success(entity);
      },showError: false);

    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

}
