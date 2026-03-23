

import 'package:base_app/core/routing/platform_page_route.dart';
import 'package:base_app/core/routing/undefined_route_screen.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/auth/presentation/modules/forget_password/forget_password_screen.dart';
import 'package:base_app/features/auth/presentation/modules/intro/splash_screen.dart';
import 'package:base_app/features/auth/presentation/modules/login/login_screen.dart';
import 'package:base_app/features/auth/presentation/modules/otp/otp_screen.dart';
import 'package:base_app/features/auth/presentation/modules/register/register_screen.dart';
import 'package:base_app/features/auth/presentation/modules/reset_password/reset_password_screen.dart';



import 'package:flutter/material.dart';




abstract class AuthRoutes  {
  static const key = 'auth/';
  //Intro
  static const String splashScreen = "${key}splashScreen";
  // static const String introScreen = "${key}introScreen";
  //Auth
  static const String loginScreen = "${key}loginScreen";
  static const String teacherLoginScreen = "${key}teacherLoginScreen";
  static const String registerScreen = "${key}registerScreen";
  static const String otpScreen = "${key}otpScreen";
  static const String forgetPasswordScreen = "${key}forgetPasswordScreen";
  static const String resetPasswordScreen = "${key}resetPasswordScreen";
}

class AuthRouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    Map? arguments = settings.arguments as Map<String, dynamic>?;

    log('AuthRouteBaseGenerator', settings.name ?? '');

      switch (settings.name) {
      //Intro
      case AuthRoutes.splashScreen:return platformPageRoute(const SplashScreen());

        // case AuthRoutes.introScreen:return platformPageRoute(const IntroScreen());
      ///Auth
      case AuthRoutes.loginScreen:return platformPageRoute( LoginScreen());
      case AuthRoutes.registerScreen:return platformPageRoute( RegisterScreen());
      case AuthRoutes.otpScreen:return platformPageRoute( OTPScreen(parameters: arguments?['parameters']));
      case AuthRoutes.forgetPasswordScreen:return platformPageRoute( ForgetPasswordScreen());
      case AuthRoutes.resetPasswordScreen:return platformPageRoute( ResetPasswordScreen(parameters: arguments?['parameters']));

        default:return platformPageRoute(const UndefinedRouteScreen());

    }
  }


}


