import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/res/resources.dart';


class CustomIntermittentDivider extends StatelessWidget {
  final double  _height ;
  final double?  _width ;
  final Color?  _color ;
  const CustomIntermittentDivider({
    super.key,
    double? height = 0.5,
    double? width,
    Color? color,
  })  : _height = height ?? 0.5,
        _width = width,
        _color = color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const  EdgeInsets.symmetric(vertical: kFormPaddingAllSmall),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 10.0;
          final dashHeight =_height;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: _color),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}