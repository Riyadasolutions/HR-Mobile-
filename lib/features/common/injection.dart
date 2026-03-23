



import 'package:base_app/base/data/injection.dart';
import 'package:base_app/features/common/data/repository/common_repository_imp.dart';

import 'package:base_app/features/common/data/repository/notification_repository_imp.dart';
import 'package:base_app/features/common/data/repository/profile_repository_imp.dart';
import 'package:base_app/features/common/domain/repository/common_repo.dart';

import 'package:base_app/features/common/domain/repository/notification_repo.dart';
import 'package:base_app/features/common/domain/repository/profile_repo.dart';
import 'package:base_app/features/common/domain/usecase/common/contact_us_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_airport_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_cities_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_countries_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_nationalities_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_privacy_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_terms_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/get_visa_types_usecase.dart';
import 'package:base_app/features/common/domain/usecase/common/home_usecase.dart';
import 'package:base_app/features/common/domain/usecase/notification/get_notification_count_usecase.dart';
import 'package:base_app/features/common/domain/usecase/notification/get_notifications_usecase.dart';
import 'package:base_app/features/common/domain/usecase/notification/read_notification_usecase.dart';


import 'package:base_app/features/common/domain/usecase/profile/get_profile_usecase.dart';
import 'package:base_app/features/common/domain/usecase/profile/update_profile_usecase.dart';
import 'package:base_app/features/common/presentation/modules/contact_us/contact_us_view_model.dart';
import 'package:base_app/features/common/presentation/modules/layout/children/home/home_view_model.dart';

import 'package:base_app/features/common/presentation/modules/layout/layout_view_model.dart';
import 'package:base_app/features/common/presentation/modules/privacy/privacy_view_model.dart';
import 'package:base_app/features/common/presentation/modules/profile/profile_view_model.dart';
import 'package:base_app/features/common/presentation/modules/setting/setting_view_model.dart';
import 'package:base_app/features/common/presentation/modules/terms/terms_view_model.dart';
import 'package:base_app/features/common/presentation/sheets/airport_picker/airport_picker_view_model.dart';
import 'package:base_app/features/common/presentation/sheets/airport_picker_by_country/airport_picker_by_country_view_model.dart';
import 'package:base_app/features/common/presentation/sheets/change_currency/currency_view_model.dart';
import 'package:base_app/features/common/presentation/sheets/city_picker/city_picker_view_model.dart';
import 'package:base_app/features/common/presentation/sheets/country_picker/country_picker_view_model.dart';
import 'package:base_app/features/common/presentation/sheets/nationality_picker/nationality_picker_view_model.dart';
import 'package:base_app/features/common/presentation/sheets/visa_type_picker/visa_type_picker_view_model.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';



List<SingleChildWidget> initCommonProvider() {
  return [



    ///Home
    ChangeNotifierProvider(create: (_) => getIt<LayoutViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<SettingViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<ProfileViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<ProfileViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<HomeViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<TermsViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<PrivacyViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<ContactUsViewModel>()),


    ///Sheets
    ChangeNotifierProvider(create: (_) => getIt<AirportPickerViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<AirportPickerByCountryViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<NationalityPickerViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<CountryPickerViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<CityPickerViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<VisaTypePickerViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<CurrencyPickerViewModel>()),

  ];
}

Future<void> initCommonFeatures() async {
  ///------------------------------ Repository ------------------------------
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImp(dioClient: getIt()));
  getIt.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImp(dioClient: getIt()));
  getIt.registerLazySingleton<CommonRepository>(() => CommonRepositoryImp(dioClient: getIt()));


  ///------------------------------ UseCase ------------------------------
  getIt.registerLazySingleton(() => GetHomeUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetCountriesUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetCitiesUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetNationalitiesUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetVisaTypesUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetAirportsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetTermsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetPrivacyUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ContactUsUseCase(repository: getIt()));

  //Notification
  getIt.registerLazySingleton(() => GetNotificationCountUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => GetNotificationsUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ReadNotificationUseCase(repository: getIt()));


  ///Profile
  getIt.registerLazySingleton(() => GetProfileUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(repository: getIt()));







  ///------------------------------ ViewModel ------------------------------


  getIt.registerLazySingleton(() => LayoutViewModel());
  getIt.registerLazySingleton(() => HomeViewModel(getHomeUseCase: getIt(),  getNotificationCountUseCase: getIt()));
  getIt.registerLazySingleton(() => SettingViewModel());
  getIt.registerLazySingleton(() => ProfileViewModel(updateProfileUseCase: getIt()));
  getIt.registerLazySingleton(() => TermsViewModel(getTermsUseCase: getIt()));
  getIt.registerLazySingleton(() => PrivacyViewModel(getPrivacyUseCase: getIt()));
  getIt.registerLazySingleton(() => ContactUsViewModel(contactUsUseCase: getIt()));


  ///Sheets
  getIt.registerLazySingleton(() => AirportPickerViewModel(getAirportsUseCase: getIt()));
  getIt.registerLazySingleton(() => AirportPickerByCountryViewModel());
  getIt.registerLazySingleton(() => NationalityPickerViewModel(getNationalitiesUseCase: getIt()));
  getIt.registerLazySingleton(() => CountryPickerViewModel(getCountriesUseCase: getIt()));
  getIt.registerLazySingleton(() => CityPickerViewModel(getCitiesUseCase: getIt()));
  getIt.registerLazySingleton(() => VisaTypePickerViewModel(getVisaTypesUseCase: getIt()));
  getIt.registerLazySingleton(() => CurrencyPickerViewModel(getUserCurrencyUseCase: getIt(),saveUserCurrencyUseCase: getIt()));


}