import 'dart:async';
import 'dart:math' as math;

import 'package:base_app/base/data/datasource/remote/dio/dio_client.dart';
import 'package:base_app/base/data/datasource/remote/exception/api_helper.dart';
import 'package:base_app/base/data/model/response/drop_down_model.dart';
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/core/api_helper/api_error_handler_new.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/common/data/model/home_model.dart';
import 'package:base_app/features/common/data/model/privacy_model.dart';
import 'package:base_app/features/common/data/model/terms_model.dart';
import 'package:base_app/features/common/data/urls.dart';
import 'package:base_app/features/common/domain/entity/home_entity.dart';
import 'package:base_app/features/common/domain/entity/privacy_entity.dart';
import 'package:base_app/features/common/domain/entity/terms_entity.dart';
import 'package:base_app/features/common/domain/parameters/contact_us_parameters.dart';
import 'package:base_app/features/common/domain/repository/common_repo.dart';
import 'package:dio/dio.dart';


class CommonRepositoryImp implements CommonRepository{
  final DioClient _dioClient;

  CommonRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;

  @override
  Future<ApiResult<List<HomeEntity>>> getHome() async {
    Response response = await _dioClient.get(CommonURLs.kHomeURL);

    return  ApiHelper.check(response, (baseModel){
      List<HomeEntity> list = [];
      baseModel.responseData.forEach((item) => list.add(HomeModel.fromJson(item,baseModel.response?['filters_available']).toEntity()));
      log('getHome', list.length.toString());
      return ApiResult< List<HomeEntity>>.success(list);
    },showError: false,tag: 'getHome');
    // if (kDemoMode) return ApiResult.success(dummyHomeSections);
    try {
      Response response = await _dioClient.get(CommonURLs.kHomeURL);

      return  ApiHelper.check(response, (baseModel){
        List<HomeEntity> list = [];
        baseModel.responseData.forEach((item) => list.add(HomeModel.fromJson(item,baseModel.response?['filters_available']).toEntity()));
        log('getHome', list.length.toString());
        return ApiResult< List<HomeEntity>>.success(list);
      },showError: false,tag: 'getHome');
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }
  // @override
  // Future<ApiResult<HomeEntity>> getHome() async {
  //   try {
  //     Response response = await _dioClient.get(CommonURLs.kHomeURL);
  //
  //     return ApiHelper.check(response, (baseModel) {
  //       final responseMap = baseModel.response as Map<String, dynamic>?;
  //       final model = HomeModel.fromJson(responseMap);
  //       return ApiResult.success(model.toEntity());
  //     }, showError: true, tag: 'getHome');
  //   } catch (e) {
  //     return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
  //   }
  // }

  @override
  Future<ApiResult<List<DropDownEntity>>> getCountries() async {
    try {
      Response response = await _dioClient.get(CommonURLs.kGetCountriesURL);
      // BaseModel baseModel = BaseModel.fromJson(response.data);
      // // HomeEntity? entity = HomeModel.fromJson(baseModel.responseData).toEntity();
      // List<DropDownEntity> list = [];
      // baseModel.responseData.forEach((item) => list.add(DropDownModel.fromJson(item).toEntity()));
      // return ApiResult.success(list);

      return  ApiHelper.check(response, (baseModel){
        List<DropDownEntity> list = [];
        baseModel.responseData.forEach((item) => list.add(DropDownModel.fromJson(item).toEntity()));
        return ApiResult.success(list);
      },showError: true,tag: 'getCountries');

    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

  @override
  Future<ApiResult<List<DropDownEntity>>> getNationalities() async {
    try {
      Response response = await _dioClient.get(CommonURLs.kGetNationalitiesURL);
      return  ApiHelper.check(response, (baseModel){
        List<DropDownEntity> list = [];
        baseModel.responseData.forEach((item) => list.add(DropDownModel.fromJson(item).toEntity()));
        return ApiResult.success(list);
      },showError: true);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

  @override
  Future<ApiResult<List<DropDownEntity>>> getVisaTypes()  async {
    try {
      Response response = await _dioClient.get(CommonURLs.kGetVisaTypesURL);
      return  ApiHelper.check(response, (baseModel){
        final data =  (baseModel.responseData as Map?)?.cast<String, dynamic>() ?? {};
        var list=  visaTypesToDropdownList(data);
        return ApiResult.success(list);
      },showError: true);

    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

  @override
  Future<ApiResult<List<DropDownEntity>>> getCities({required int countryId})  async {
    try {
      Response response = await _dioClient.get(CommonURLs.kGetCitiesURL,queryParameters: {'country_id':countryId},isRow:true);
      return  ApiHelper.check(response, (baseModel){
        List<DropDownEntity> list = [];
        baseModel.responseData.forEach((item) => list.add(DropDownModel.fromJson(item).toEntity()));
        return ApiResult.success(list);
      },showError: true);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

  @override
  Future<ApiResult<List<DropDownEntity>>> getAirport({required int countryId})  async {
    try {
      Response response = await _dioClient.get(CommonURLs.kGetAirportURL,queryParameters: {'country_id':countryId},isRow:true);
      return  ApiHelper.check(response, (baseModel){
        List<DropDownEntity> list = [];
        baseModel.responseData.forEach((item) => list.add(DropDownModel.fromJson(item).toEntity()));
        return ApiResult.success(list);
      },showError: true);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

  @override
  Future<ApiResult<TermsEntity>> getTerms() async {
    try {
      Response response = await _dioClient.get(CommonURLs.kGetTermsURL);
      return ApiHelper.check(response, (baseModel) {
        final termsModel = TermsModel.fromJson(baseModel.responseData as Map<String, dynamic>?);
        return ApiResult.success(termsModel.toEntity());
      }, showError: false);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

  @override
  Future<ApiResult<PrivacyEntity>> getPrivacy() async {
    try {
      Response response = await _dioClient.get(CommonURLs.kGetPrivacyURL);
      return ApiHelper.check(response, (baseModel) {
        final privacyModel = PrivacyModel.fromJson(baseModel.responseData as Map<String, dynamic>?);
        return ApiResult.success(privacyModel.toEntity());
      }, showError: false);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

  @override
  Future<ApiResult> contactUs({required ContactUsParameters parameters}) async {
    try {
      Response response = await _dioClient.post(
        CommonURLs.kContactUsURL,
        dataParameters: parameters.toJson(),
      );
      return ApiHelper.check(response, (baseModel) {
        return ApiResult.success(true);
      }, showError: true, showSuccess: true);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandlerNew.getMessage(e));
    }
  }

}
List<DropDownEntity> visaTypesToDropdownList(Map<String, dynamic> data) {
  final rnd = math.Random();

  return data.entries.toList().asMap().entries.map((e) {
    final index = e.key;           // 0..n
    final entry = e.value;         // MapEntry(key, value)

    return DropDownEntity(
      id: index + 1,
      key: entry.key,              // "tourist"
      title: entry.value.toString(), // "Tourist Visa"
      color: (rnd.nextDouble() * 0xFFFFFF).toInt(),
    );
  }).toList();
}