import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';

class CustomCard extends StatelessWidget {
  final Widget _child;
  final double? _radius;
  final Color? _color;
  final Color? _shadowColor;
  final double _elevation;

  const CustomCard({super.key,
    required Widget child,
    double? radius,
    Color? color,
    Color? shadowColor,
    double elevation = 1,
  })  : _child = child,
        _radius = radius,
        _color = color,
        _shadowColor = shadowColor,
        _elevation = elevation;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: const BoxDecoration().borderStyle(width: _elevation, ).radius(radius: _radius??kFormRadius).customColor(_color??Theme.of(context).cardColor),
    //   child: _child,
    // );
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_radius??kCartRadius))),
      shadowColor: _shadowColor,
      elevation: _elevation,
      color: _color??Theme.of(context).cardColor,

      // color: _color??Theme.of(context).highlightColor, //Colors.white,
      surfaceTintColor: _color??Theme.of(context).cardColor,

      child: _child,
    );
  }


}
