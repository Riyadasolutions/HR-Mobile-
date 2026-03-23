import 'dart:io';

import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/injection.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'providers.dart';
import 'firebase_options.dart';


import 'package:flutter_dotenv/flutter_dotenv.dart';



class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Load env file

  // String.fromEnvironment('API_URL', defaultValue: 'https://api.example.com');
  // // init logger
  // Logger.root.level = Level.ALL; // defaults to Level.INFO
  // Logger.root.onRecord.listen((record) {
  //   // print('${record.level.name}: ${record.time}: ${record.message}');
  // });
  await Future.delayed(const Duration(milliseconds: 300));


  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await injection();

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => GenerateMultiProvider(
      child: EasyLocalization(
          supportedLocales: Constants.kSupportedLocales,
          path: 'assets/translations',
          // if device language not supported
          fallbackLocale: Constants.kSupportedLocales[0],
          saveLocale: true,
          useOnlyLangCode: true,
          child: const MyApp()),
    ),
  ));
}


