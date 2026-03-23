import 'dart:async';

import 'package:base_app/base/data/datasource/remote/dio/dio_client.dart';
import 'package:base_app/base/data/datasource/remote/exception/api_helper.dart';
import 'package:base_app/core/api_helper/api_error_handler_new.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/data/model/profile_model.dart';
import 'package:base_app/features/auth/domain/entity/profile_entity.dart';
import 'package:base_app/features/auth/domain/parameters/profile_parameters.dart';
import 'package:base_app/features/common/data/urls.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/profile_repo.dart';


class ProfileRepositoryImp implements ProfileRepository{
  final DioClient _dioClient;

  ProfileRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;

  @override
  Future<ApiResult<ProfileEntity>> getProfile() async {
    // if (kDemoMode) return ApiResult.success(demoProfile);

    try {
      Response response = await _dioClient.get(CommonURLs.kGetProfileURL);
      return  ApiHelper.check(response, (baseModel){
        ProfileEntity? entity = ProfileModel.fromJson(baseModel.responseData).toEntity();
        return ApiResult<ProfileEntity>.success(entity);
      },showError: false);




    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

  @override
  Future<ApiResult<ProfileEntity>> updateProfile({required ProfileParameters parameters}) async {
    try {
      Response response = await _dioClient.post(CommonURLs.kUpdateProfileURL,queryParameters: parameters.toJson());
      return  ApiHelper.check(response, tag: 'updateProfile',(baseModel){
        ProfileEntity? entity = ProfileModel.fromJson(baseModel.responseData).toEntity();
        return ApiResult<ProfileEntity>.success(entity);
      },showError: false);

      // BaseModel baseModel = BaseModel.fromJson(response.data);
      // ProfileEntity? entity = ProfileModel.fromJson(baseModel.responseData).toEntity();
      // return ApiResult.success(entity);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }




}
