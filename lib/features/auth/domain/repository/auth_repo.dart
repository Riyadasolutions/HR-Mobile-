


import 'package:base_app/core/api_helper/api_result.dart';
import 'package:base_app/features/auth/domain/entity/auth_entity.dart';
import 'package:base_app/features/auth/domain/parameters/forget_password_parameters.dart';
import 'package:base_app/features/auth/domain/parameters/login_parameters.dart';
import 'package:base_app/features/auth/domain/parameters/register_parameters.dart';


mixin AuthRepository {
  Future<ApiResult<AuthEntity>> login({required LoginParameters parameters}) ;
  Future<ApiResult<AuthEntity>> register({required RegisterParameters parameters}) ;

  Future<ApiResult> deleteAccount();
  Future<ApiResult> logout();
  Future<ApiResult<AuthEntity>> verifyOtpCode({required ForgetPasswordParameters parameters});

  Future<ApiResult> fcmTokenUpdate({required String? fcmToken});

  Future<ApiResult<AuthEntity>> checkOtpCode({required ForgetPasswordParameters parameters});
  Future<ApiResult> forgetPassword({required ForgetPasswordParameters parameters});
  Future<ApiResult<AuthEntity>> resetPassword({required ForgetPasswordParameters parameters});


}
