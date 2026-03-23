import 'package:base_app/features/auth/domain/parameters/profile_parameters.dart';
import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/entity/profile_entity.dart';

mixin ProfileRepository {
  Future<ApiResult<ProfileEntity>> getProfile();
  Future<ApiResult<ProfileEntity>> updateProfile({required ProfileParameters parameters});
}
