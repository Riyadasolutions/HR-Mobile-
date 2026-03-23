import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';




class UndefinedRouteScreen extends StatelessWidget {
  const UndefinedRouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child:Text(tr(LocaleKeys.noRouteFound),style: const TextStyle().titleStyle(),) ,
      ),
    );
  }
}
