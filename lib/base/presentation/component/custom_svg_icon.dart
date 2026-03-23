import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:base_app/core/extensions/num_extensions.dart';

class CustomSVGIcon extends StatelessWidget {
  final String _assets;
  final Color? _color;
  final double? _height;
  final double? _width;
  final double? _size;

  const CustomSVGIcon(
    String assets, {
    super.key,
    Color? color,
    double? height,
    double? width,
    double? size,
  })  : _assets = assets,
        _color = color,
        _size = size,
        _height = height,
        _width = width;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: _size ?? _height ?? 24.r,
        width: _size ?? _width ?? 24.r,
        child: Center(
          child: SvgPicture.asset(
            _assets,
            height: _size ?? _height ?? 24.r,
            width: _size ?? _width ?? 24.r,
            color: _color,
          ),
        ),
      );
}
