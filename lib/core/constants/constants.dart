

import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/utils/language_helper.dart';
import 'package:base_app/base/presentation/component/inputs/country/countries.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Constants {
   // static const String appVersion= '2.25';
   // static const String versionInternal= '1';
   // static const bool enableWhatApp= true;
   // static const String environment= 'production'; //'production', 'development'



  static const String empty = "";
  static const int connectTimeout = 30000;

  static const String kDefaultCurrencySymbol = 'USD';

  static const Country initMobileCountry = kDebugMode
      ? Country(name: "Egypt", flag: "🇪🇬", code: "EG", dialCode: "20", minLength: 10, maxLength: 10,)
      : Country(name: "Saudi Arabia", flag: "🇸🇦", code: "SA", dialCode: "966", minLength: 9, maxLength: 9);




  static const String kGoogleMapKey = 'AIzaSyBFCnlrpNKXtVn8YROYBO8N52SRzOhP8JA';

  static const String kDefaultMapLinkStyle ='';
  static const String kDefaultMapLinkStyled =
  '&style=feature:all|element:labels.text.fill|color:0x444444'
      '&style=feature:all|element:labels.text.stroke|color:0xffffff'
      '&style=feature:all|element:labels.icon|visibility:off'
      '&style=feature:administrative|element:geometry.fill|color:0xe0e0e0'
      '&style=feature:administrative|element:geometry.stroke|color:0xaaaaaa'
      '&style=feature:landscape|element:geometry|color:0xf5f5f5'
      '&style=feature:poi|element:geometry|color:0xeeeeee'
      '&style=feature:road|element:geometry|color:0xffffff'
      '&style=feature:road.arterial|element:geometry|color:0xdddddd'
      '&style=feature:water|element:geometry|color:0xdcdcdc';


  // static String googleMapImageLink({ double height=450,required double? widget,required num latitude,required num longitude})=>
  //     'http://maps.google.com/maps/api/staticmap?zoom=18&key=${Constants.kGoogleMapKey}&size=800x450&markers=$latitude,$longitude&sensor=false[/IMG]';
  //

  static String googleMapImageLink({double? height, double? width, required num latitude, required num longitude}) {
    final w = width ?? 800;
    final h = height ?? 450;

    // return 'https://maps.google.com/maps/api/staticmap''?zoom=18''&key=${Constants.kGoogleMapKey}''&size=${w.toInt()}x${h.toInt()}''&markers=$latitude,$longitude''&sensor=false';


    // نمط مظلم مبسط (منسق بشكل يصلح للرابط)

    return 'https://maps.googleapis.com/maps/api/staticmap''?zoom=18''&size=${w.toInt()}x${h.toInt()}''&markers=color:red%7C$latitude,$longitude''&key=${Constants.kGoogleMapKey}''$kDefaultMapLinkStyle''&sensor=false';
    return 'https://maps.googleapis.com/maps/api/staticmap''?zoom=16''&key=${Constants.kGoogleMapKey}''&size=${w.toInt()}x${h.toInt()}''&markers=$latitude,$longitude''$kDefaultMapLinkStyle''&sensor=false';
  }

  static const kSupportedCurrencies = [
    'SAR',
    'USD',
  ];

  static const kSupportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

}
double kConvertToDouble(var d) => d / 1 ;

String kConvertListToString(List<String?> list) =>list.join(',');


String kGetLanguageValue({required String valueAr ,required String valueEn}) =>  kIsArabic?(valueAr.isNotEmpty?valueAr:valueEn):(valueEn.isNotEmpty?valueEn:valueAr);






EdgeInsets kScreenPadding = EdgeInsets.all(kScreenPaddingNormal.r).copyWith(top: 0);
EdgeInsets kCardPadding = EdgeInsets.all(kScreenPaddingNormal.r);
