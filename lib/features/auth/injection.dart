



import 'package:base_app/base/data/injection.dart';
import 'package:base_app/features/auth/data/repository/local_repository_imp.dart';
import 'package:base_app/features/auth/domain/provider/local_auth_provider.dart';
import 'package:base_app/features/auth/domain/repository/local_repo.dart';
import 'package:base_app/features/auth/domain/usecase/check_otp_usecase.dart';

import 'package:base_app/features/auth/domain/usecase/delete_account_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/currency/get_currency_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/currency/save_currency_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/logout_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/register_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/send_otp_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/update_fcm_token_usecase.dart';
import 'package:base_app/features/auth/data/repository/auth_repository_imp.dart';
import 'package:base_app/features/auth/domain/repository/auth_repo.dart';
import 'package:base_app/features/auth/domain/usecase/verify_otp_code_usecase.dart';
import 'package:base_app/features/auth/presentation/modules/forget_password/forget_password_view_model.dart';


import 'package:base_app/features/auth/presentation/modules/login/login_view_model.dart';
import 'package:base_app/features/auth/presentation/modules/otp/otp_view_model.dart';
import 'package:base_app/features/auth/presentation/modules/register/register_view_model.dart';
import 'package:base_app/features/auth/presentation/modules/reset_password/reset_password_view_model.dart';


import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


import 'package:base_app/features/auth/domain/usecase/local/clear_user_data_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/get_is_first_time_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/get_is_login_usecase.dart';
import 'package:base_app/features/auth/domain/usecase/local/save_data_usecase.dart';

List<SingleChildWidget> initAuthProvider() {
  return [
    ///Locale
    ChangeNotifierProvider(create: (_) => getIt<LocalAuthProvider>()),

    ///Auth
    ChangeNotifierProvider(create: (_) => getIt<LoginViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<RegisterViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<OTPViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<ResetPasswordViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<ForgetPasswordViewModel>()),
  ];
}


Future<void> initAuthFeatures() async {
  ///------------------------------ Repository ------------------------------
  getIt.registerLazySingleton<AuthRepository>(() =>AuthRepositoryImp(dioClient: getIt()));
  getIt.registerLazySingleton<LocalRepository>(() => LocalRepositoryImp(dioClient: getIt(),cacheConsumer: getIt()));


  ///------------------------------ UseCase ------------------------------
  getIt.registerLazySingleton(() => LoginUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => SendOTPUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => CheckOTPUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ResetPasswordUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => RegisterUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => DeleteAccountUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => VerifyOtpCodeUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateFCMTokenUseCase(repository: getIt()));
  ///Locale
  getIt.registerLazySingleton(() => SaveUserCurrencyUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetUserCurrencyUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ClearUserDataUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => IsUserLoginUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetIsFirstTimeUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => SaveUserDataUseCase(repository: getIt()));


  ///------------------------------ ViewModel ------------------------------
  ///Locale
  getIt.registerLazySingleton(() => LocalAuthProvider(getUserCurrencyUseCase: getIt(),saveUserCurrencyUseCase: getIt(),updateFCMTokenUseCase: getIt(),deleteAccountUseCase: getIt(),clearUserDataUseCase: getIt(), getIsFirstTimeUseCase: getIt(), logoutUseCase: getIt(), isUserLoginUseCase: getIt(), getProfileUseCase: getIt()));

  ///Auth
  getIt.registerLazySingleton(() => LoginViewModel(saveUserDataUseCase: getIt(),loginUseCase: getIt()));
  getIt.registerLazySingleton(() => RegisterViewModel(saveUserDataUseCase: getIt(),registerUseCase: getIt()));
  getIt.registerLazySingleton(() => ResetPasswordViewModel(resetPasswordUseCase: getIt()));
  getIt.registerLazySingleton(() => ForgetPasswordViewModel(sendOTPUseCase: getIt()));
  getIt.registerLazySingleton(() => OTPViewModel(saveUserDataUseCase: getIt(), checkOTPUseCase: getIt(), sendOTPUseCase: getIt()));

}