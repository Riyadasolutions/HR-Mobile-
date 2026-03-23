
import 'package:base_app/core/routing/platform_page_route.dart';
import 'package:base_app/core/routing/undefined_route_screen.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/common/presentation/modules/contact_us/contact_us_screen.dart';
import 'package:base_app/features/common/presentation/modules/delete_account.dart';
import 'package:base_app/features/common/presentation/modules/image_slider/image_slider_screen.dart';
import 'package:base_app/features/common/presentation/modules/layout/layout_screen.dart';
import 'package:base_app/features/common/presentation/modules/privacy/privacy_screen.dart';
import 'package:base_app/features/common/presentation/modules/profile/profile_screen.dart';
import 'package:base_app/features/common/presentation/modules/setting/setting_screen.dart';
import 'package:base_app/features/common/presentation/modules/terms/terms_screen.dart';

import 'package:flutter/material.dart';




abstract class CommonRoutes  {
  static const key = 'common/';

  static const String layoutScreen  = "${key}layoutScreen";
  static const String notificationsScreen  = "${key}notificationsScreen";
  static const String settingScreen  = "${key}settingScreen";
  static const String imageSliderScreen  = "${key}imageSliderScreen";
  static const String profileScreen  = "${key}profileScreen";
  static const String deleteAccountScreen = "${key}deleteAccountScreen";
  static const String termsScreen = "${key}termsScreen";
  static const String privacyScreen = "${key}privacyScreen";
  static const String contactUsScreen = "${key}contactUsScreen";




}

class CommonRouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    Map? arguments = settings.arguments as Map<String, dynamic>?;

    log('RouteBaseGenerator', settings.name ?? '');

      switch (settings.name) {
        case CommonRoutes.layoutScreen:return platformPageRoute(LayoutScreen(currentPage:  arguments?['currentPage']));
        case CommonRoutes.settingScreen:return platformPageRoute(SettingScreen());
        case CommonRoutes.profileScreen:return platformPageRoute(ProfileScreen());
        case CommonRoutes.imageSliderScreen:return platformPageRoute( ImageSliderScreen(images: arguments?['images'],currentIndex: arguments?['index'],));
        case CommonRoutes.deleteAccountScreen:return platformPageRoute( const DeleteAccountScreen());
        case CommonRoutes.termsScreen:return platformPageRoute(const TermsScreen());
        case CommonRoutes.privacyScreen:return platformPageRoute(const PrivacyScreen());
        case CommonRoutes.contactUsScreen:return platformPageRoute(const ContactUsScreen());


        default:return platformPageRoute(const UndefinedRouteScreen());

    }
  }


}


