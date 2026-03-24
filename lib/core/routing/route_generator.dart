import 'package:base_app/features/auth/route_generator.dart';
import 'package:base_app/features/common/route_generator.dart';

import 'package:flutter/material.dart';

import 'platform_page_route.dart';
import 'undefined_route_screen.dart';

class RouteBaseGenerator {
  static Route generateRoute(RouteSettings settings) {

    //common
    // if ((settings.name ?? '').startsWith(ServicesRoutes.key)) {return ServicesRouteGenerator.generateRoute(settings);}
    if ((settings.name ?? '').startsWith(CommonRoutes.key)) {return CommonRouteGenerator.generateRoute(settings);}
    //auth
    if ((settings.name ?? '').startsWith(AuthRoutes.key)) {return AuthRouteGenerator.generateRoute(settings);}
    // if ((settings.name ?? '').startsWith(BookingRoutes.key)) {return BookingRouteGenerator.generateRoute(settings);}
    // if ((settings.name ?? '').startsWith(HotelRoutes.key)) {return HotelRouteGenerator.generateRoute(settings);}


    return platformPageRoute(const UndefinedRouteScreen());

  }
}
