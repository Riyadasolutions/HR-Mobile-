import 'package:flutter/material.dart';

@immutable
class NavigationTab {
  const NavigationTab({
    required this.title,
    required this.icon,
    required this.initialRoute,
    required this.index,
  });

  final String title;
  final String icon;
  final Widget initialRoute;
  final int index;
}
