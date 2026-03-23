import 'package:base_app/core/res/resources.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:base_app/core/extensions/num_extensions.dart';

class CustomActionSVGIcon extends StatelessWidget {
  final String _assets;
  final String _title;
  final Color? _color;
  final double? _height;
  final double? _width;
  final double? _size;

  final GestureTapCallback? _onTap;

  const CustomActionSVGIcon(
    String assets,
    String title, {
    super.key,
    Color? color,
    double? height,
    double? width,
    GestureTapCallback? onTap,
    double? size,
  })  : _assets = assets,
        _title = title,
        _color = color,
        _size = size,
        _onTap = onTap,
        _height = height,
        _width = width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _onTap,
          child: SizedBox(
            height: _size ?? _height ?? 40.r,
            width: _size ?? _width ?? 40.r,
            child: SvgPicture.asset(
              _assets,
            ),
          ),
        ),
        VerticalSpace(kFormPaddingAllSmall.h),
        Text(_title, style: TextStyle().regularStyle(fontSize: 14)),
      ],
    );
  }
// @override
// Widget build(BuildContext context) => SizedBox(
//     height: _size ?? _height ?? 24.r,
//     width: _size ?? _width ?? 24.r,
//     child: Center(
//         child: SvgPicture.asset(
//       _assets,
//       height: _size ?? _height ?? 24.r,
//       width: _size ?? _width ?? 24.r,
//       color: _color,
//     )));
}
