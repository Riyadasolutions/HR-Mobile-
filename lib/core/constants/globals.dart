
import 'dart:io';

import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/features/auth/domain/entity/profile_entity.dart';

bool kDemoMode=true;
kClearGlobalData(){
  kUser= null;
}

// ProfileEntity? kUser;
String kUserCurrency =Constants.kDefaultCurrencySymbol;

 ProfileEntity? kUser ;/*= ProfileEntity(
  id: 1,
  name: 'Ahmed Ali',
  title: 'Guest User',
  email: 'user@example.com',
  mobileCode: '+966',
  mobile: '512345678',
  image: 'https://example.com/avatar.png',
  address: 'Al Ahsa, Saudi Arabia',
  appLanguage: 'ar',
  faceToken: 'sss',
  providerTeam: [],
  gender: 'male',
  dateOfBirth: '1995, 5, 12',
);*/

bool get kIsDark => Platform.isAndroid ? true : false;

bool get kIsAuth => kUser!=null ;


