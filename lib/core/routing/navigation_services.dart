import 'package:flutter/widgets.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static Future<dynamic> push(String route, {Map<String, dynamic>? arguments}) async {
    return await Navigator.pushNamed(navigationKey.currentContext!, route, arguments: arguments,);
  }

  static Future<dynamic> pushReplacement(String route, {Map<String, dynamic>? arguments}) async {
    return await Navigator.pushReplacementNamed(navigationKey.currentContext!, route, arguments: arguments);
  }

  static Future<dynamic> pushNamedAndRemoveUntil(String route, {Map<String, dynamic>? arguments}) async {

    return await Navigator.pushNamedAndRemoveUntil(navigationKey.currentContext! ,route, (route) => false, arguments: arguments);
  }

  // Navigator.push(
  //     context,
  //     PageRouteBuilder(
  //         transitionDuration: Duration(milliseconds: 1000),
  //         pageBuilder: (_, __, ___) => LoginScreen()));
  static dynamic goBack([Object? result]) {
    return Navigator.pop(navigationKey.currentContext!, result);
  }
}
