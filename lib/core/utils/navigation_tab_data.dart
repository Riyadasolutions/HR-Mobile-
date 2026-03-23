
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


@immutable
class NavigationTabData {

  final String _title;
  final String _icon;
  final Widget _initialRoute;
  final int _index;

  int get index => _index;

  Widget get initialRoute => _initialRoute;


  String get icon => _icon;

  String get title => _title;

  const NavigationTabData({
    required String title,
    required String icon,
    required Widget initialRoute,
    required int index,
  })  : _title = title,
        _icon = icon,
        _initialRoute = initialRoute,
        _index = index;

}
