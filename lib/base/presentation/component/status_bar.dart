import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomStatusBar extends StatelessWidget {
  final Widget _child;
  final bool _isDark;
  final Color? _color;
  const CustomStatusBar({super.key,
    required Widget child,
     bool isDark= true,
     Color? color,
  })  : _child = child,
        _isDark = isDark,
        _color = color;



  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: _color ?? Colors.transparent,
        systemNavigationBarColor: _color ?? Colors.transparent,
        systemNavigationBarIconBrightness:_isDark?Brightness.dark: Brightness.light,
        systemNavigationBarDividerColor: _color ?? Colors.transparent,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: true,

        // Status bar brightness (optional)
        statusBarIconBrightness:_isDark? Brightness.dark: Brightness.light, // For Android (dark icons)
        statusBarBrightness: _isDark?Brightness.dark: Brightness.light , // For iOS (dark icons)
      ),

      child: _child,
    );
  }


}
