


import 'package:base_app/base/data/injection.dart';
import 'package:base_app/core/res/theme_helper.dart';
import 'package:base_app/core/utils/timer_helper.dart';
import 'package:base_app/features/auth/injection.dart';




 
Future<void> injection() async {
  await init();

  ///Base
  initBaseData();
  // initBaseDomain();
  // initBasePresentation();


  await initAuthFeatures();
  // await initCommonFeatures();
  // await initBookingFeatures();
  //
  // await initHotelFeatures();
  // await initServiceFeatures();



}
Future<void> init() async {


  getIt.registerLazySingleton(() => TimerHelper());
  getIt.registerLazySingleton(() => ThemeHelper(sharedPreferences: getIt()));
}
