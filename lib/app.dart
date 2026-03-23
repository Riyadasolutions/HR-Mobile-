
import 'dart:ui' as ui;

import 'package:base_app/base/presentation/component/status_bar.dart';
import 'package:base_app/core/res/theme_helper.dart';
import 'package:base_app/features/auth/presentation/modules/intro/splash_screen.dart';
import 'package:base_app/features/auth/route_generator.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/res/theme/theme.dart';
import 'core/routing/navigation_services.dart';
import 'core/routing/route_generator.dart';

BuildContext? appContext;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Provider.of<ThemeHelper>(context,listen: false).getCurrentTheme();
    // getIt<SettingViewModel>().getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemeHelper>().isDarkMode;

    appContext = NavigationService.navigationKey.currentContext??context;
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      color:Theme.of(context).scaffoldBackgroundColor,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'CareConnect',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigationKey,
      navigatorObservers: [NavigationService.routeObserver],
      initialRoute: AuthRoutes.splashScreen,
      useInheritedMediaQuery: true,

      builder: DevicePreview.appBuilder,
      onGenerateRoute: RouteBaseGenerator.generateRoute,
      home: Directionality(
        textDirection: context.locale.languageCode == 'ar' ? ui.TextDirection.rtl : ui.TextDirection.ltr,
        child: CustomStatusBar(
          color: Theme.of(context).primaryColorDark,
          isDark: true,
          child: const SplashScreen(),
          // child: (/* child ??*/ const SizedBox()),
        ),
      ),

    );
  }
}
