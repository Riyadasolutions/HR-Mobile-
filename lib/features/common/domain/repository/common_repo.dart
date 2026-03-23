import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/core/api_helper/api_result.dart';

import '../entity/home_entity.dart';
import '../entity/privacy_entity.dart';
import '../entity/terms_entity.dart';
import '../parameters/contact_us_parameters.dart';

mixin CommonRepository {
  Future<ApiResult<List<HomeEntity>>> getHome();

  Future<ApiResult<List<DropDownEntity>>> getCities({required int countryId}) ;
  Future<ApiResult<List<DropDownEntity>>> getCountries() ;
  Future<ApiResult<List<DropDownEntity>>> getVisaTypes() ;
  Future<ApiResult<List<DropDownEntity>>> getNationalities() ;
  Future<ApiResult<List<DropDownEntity>>> getAirport({required int countryId}) ;

  Future<ApiResult<TermsEntity>> getTerms();
  Future<ApiResult<PrivacyEntity>> getPrivacy();
  Future<ApiResult> contactUs({required ContactUsParameters parameters});

}
