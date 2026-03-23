import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';

class CustomDivider extends StatelessWidget {
  final double  _height ;
  final double?  _width ;
  final Color?  _color ;
  const CustomDivider({
    super.key,
    double? height = 0.3,
    double? width,
    Color? color,
  })  : _height = height ?? 0.3,
        _width = width,
        _color = color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width??deviceWidth,
      color:_color?? AppColor.hintColor.themeColor,
    );
  }


}
class MySeparator extends StatelessWidget {

  final double _height;
  final Color _color;
  const MySeparator({super.key,
    required double height,
     required Color color,
  })  : _height = height,
        _color = color;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = _height;
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
    );
  }


}